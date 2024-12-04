//
//  WishMakerAssembly.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 03.12.2024.
//

import UIKit

// Build screen.
enum WishMakerAssembly {
    static func build() -> UIViewController {
        let presenter = WishMakerPresenter()
        let interactor = WishMakerInteractor(presenter: presenter)
        let view = WishMakerViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
