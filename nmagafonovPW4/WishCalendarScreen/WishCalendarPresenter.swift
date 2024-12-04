//
//  WishCalendarPresenter.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 04.12.2024.
//

import UIKit

final class WishCalendarPresenter: WishCalendarPresentationLogic {
    weak var view: WishCalendarViewController?
    
    func presentStart(_ request: WishCalendarModel.Start.Response) {
        view?.displayStart(WishCalendarModel.Start.ViewModel(events: request.events))
    }
    
    func presentOther(_ request: WishCalendarModel.Other.Response) {
        view?.displayOther()
    }
    
    func routeTo() {
        view?.navigationController?.pushViewController(UIViewController(), animated: true)
    }
}
