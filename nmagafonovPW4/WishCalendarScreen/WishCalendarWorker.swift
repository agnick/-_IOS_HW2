//
//  WishCalendarWorker.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 04.12.2024.
//

import CoreData
import UIKit

// A worker responsible for interacting with Core Data to fetch wish events.
final class WishCalendarWorker {
    // Fetches all wish events stored in Core Data and maps them to WishEventModel objects.
    func fetchEvents() -> [WishEventModel] {
        // Attempt to get the Core Data context from the AppDelegate.
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return []
        }
        
        // Create a fetch request for the "Event" entity.
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Event")
        
        do {
            // Perform the fetch request to retrieve stored events.
            let results = try context.fetch(fetchRequest)
            
            return results.compactMap { event in
                // Extract and validate the necessary fields from the Core Data object.
                guard let title = event.value(forKey: "title") as? String,
                      let description = event.value(forKey: "eventDescription") as? String,
                      let startDate = event.value(forKey: "startDate") as? Date,
                      let endDate = event.value(forKey: "endDate") as? Date else { return nil }
                
                // Format the dates to a string format.
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                
                return WishEventModel(
                    title: title,
                    description: description,
                    startDate: formatter.string(from: startDate),
                    endDate: formatter.string(from: endDate)
                )
            }
        } catch {
            print("Failed to fetch events: \(error)")
            return []
        }
    }
}
