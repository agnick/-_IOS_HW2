//
//  WishEventCreationPresenter.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 04.12.2024.
//

import UIKit

final class WishEventCreationPresenter: WishEventCreationPresentationLogic {
    weak var view: WishEventCreationViewController?
    
    func presentStart(_ request: WishEventCreationModel.Start.Response) {
        view?.displayStart()
    }
    
    func presentOther(_ request: WishEventCreationModel.Other.Response) {
        view?.displayOther(WishEventCreationModel.Other.ViewModel(success: request.success, message: request.message))
    }
    
    func routeTo() {
        view?.navigationController?.pushViewController(UIViewController(), animated: true)
    }
}
