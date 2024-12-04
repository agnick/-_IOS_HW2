//
//  WishEventCreationInteractor.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 04.12.2024.
//

final class WishEventCreationInteractor: WishEventCreationBusinessLogic {
    private let presenter: WishEventCreationPresentationLogic
    private let calendarManager: CalendarManaging
    
    init (presenter: WishEventCreationPresentationLogic, calendarManager: CalendarManaging) {
        self.presenter = presenter
        self.calendarManager = calendarManager
    }
    
    // Loads the initial state of the view.
    func loadStart(_ request: WishEventCreationModel.Start.Request) {
        presenter.presentStart(WishEventCreationModel.Start.Response())
    }
    
    // Handles the creation of a new event.
    func loadOther(_ request: WishEventCreationModel.Other.Request) {
        // Validate that the end date is greater than or equal to the start date.
        guard request.startDate <= request.endDate else {
            presenter.presentOther(WishEventCreationModel.Other.Response(success: false, message: "End date must be greater than or equal to start date."))
            return
        }
        
        // Save event in CoreData.
        let worker = WishEventCreationWorker()
        let isSavedToCoreData = worker.saveEvent(
            title: request.title,
            description: request.description,
            startDate: request.startDate,
            endDate: request.endDate
        )
        
        // Create event in Calendar.
        let eventModel = CalendarEventModel(
            title: request.title,
            startDate: request.startDate,
            endDate: request.endDate,
            eventDescription: request.description
        )
        
        let isSavedToCalendar = calendarManager.create(eventModel: eventModel)
        
        // Determine overall success based on both operations.
        let success = isSavedToCoreData && isSavedToCalendar
        
        // Respond to the presenter based on the operation results.
        if success {
            presenter.presentOther(WishEventCreationModel.Other.Response(success: true, message: "Event saved successfully"))
        } else {
            presenter.presentOther(WishEventCreationModel.Other.Response(success: false, message: "Failed to save event"))
        }
    }
}
