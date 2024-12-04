//
//  WishEventCreationAssembly.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 04.12.2024.
//

import UIKit

// Build screen.
enum WishEventCreationAssembly {
    static func build() -> WishEventCreationViewController {
        let presenter = WishEventCreationPresenter()
        let calendarManager = CalendarManager()
        let interactor = WishEventCreationInteractor(presenter: presenter, calendarManager: calendarManager)
        let viewController = WishEventCreationViewController(interactor: interactor)
        presenter.view = viewController

        return viewController
    }
}
