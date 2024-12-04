//
//  WishStoringPresenter.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 03.12.2024.
//

import UIKit

final class WishStoringPresenter: WishStoringPresentationLogic {
    weak var view: WishStoringViewController?
    
    func presentWishes(_ response: WishStoringModel.Start.Response) {
        let viewModel = WishStoringModel.Start.ViewModel(wishes: response.wishes)
        view?.displayWishes(viewModel)
    }
}
