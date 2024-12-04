//
//  WishEventCreationWorker.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 04.12.2024.
//

import CoreData
import UIKit

final class WishEventCreationWorker {
    // Saves an event to CoreData.
    func saveEvent(title: String, description: String, startDate: Date, endDate: Date) -> Bool {
        // Retrieve the CoreData context from the AppDelegate.
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Create a new event entity in CoreData.
        let event = NSEntityDescription.insertNewObject(forEntityName: "Event", into: context)
        event.setValue(title, forKey: "title")
        event.setValue(description, forKey: "eventDescription")
        event.setValue(startDate, forKey: "startDate")
        event.setValue(endDate, forKey: "endDate")
        
        // Save the context.
        do {
            try context.save()
            
            return true
        } catch {
            print("Failed to save event: \(error)")
            
            return false
        }
    }
}
