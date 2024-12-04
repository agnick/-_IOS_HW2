//
//  WishStoringAssembly.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 03.12.2024.
//

import UIKit

// Build screen.
enum WishStoringAssembly {
    static func build() -> UIViewController {
        let presenter = WishStoringPresenter()
        let interactor = WishStoringInteractor(presenter: presenter)
        let view = WishStoringViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
