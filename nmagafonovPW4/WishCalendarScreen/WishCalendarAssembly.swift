//
//  WishCalendarAssembly.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 04.12.2024.
//

import UIKit

// Build screen.
enum WishCalendarAssembly {
    static func build() -> WishCalendarViewController {
        let presenter = WishCalendarPresenter()
        let interactor = WishCalendarInteractor(presenter: presenter)
        let viewController = WishCalendarViewController(interactor: interactor)
        presenter.view = viewController

        return viewController
    }
}
