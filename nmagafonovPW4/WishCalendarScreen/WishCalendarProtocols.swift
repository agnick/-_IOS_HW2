//
//  WishCalendarProtocols.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 04.12.2024.
//

protocol WishCalendarBusinessLogic {
    func loadStart(_ request: WishCalendarModel.Start.Request)
    func loadOther(_ request: WishCalendarModel.Other.Request)
}

protocol WishCalendarPresentationLogic {
    func presentStart(_ response: WishCalendarModel.Start.Response)
    func presentOther(_ response: WishCalendarModel.Other.Response)
    
    func routeTo()
}
