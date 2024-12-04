//
//  WishCalendarInteractor.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 04.12.2024.
//

final class WishCalendarInteractor: WishCalendarBusinessLogic {
    private let presenter: WishCalendarPresentationLogic
    private let worker = WishCalendarWorker()
    
    init (presenter: WishCalendarPresentationLogic) {
        self.presenter = presenter
    }
    
    func loadStart(_ request: WishCalendarModel.Start.Request) {
        let events = worker.fetchEvents()
        presenter.presentStart(WishCalendarModel.Start.Response(events: events))
    }
    
    func loadOther(_ request: WishCalendarModel.Other.Request) {
        presenter.presentOther(WishCalendarModel.Other.Response())
    }
}
