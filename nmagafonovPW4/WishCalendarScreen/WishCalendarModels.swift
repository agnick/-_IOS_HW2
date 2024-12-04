//
//  WishCalendarModels.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 04.12.2024.
//

enum WishCalendarModel {
    enum Start {
        struct Request {}
        struct Response {
            let events: [WishEventModel]
        }
        struct ViewModel {
            let events: [WishEventModel]
        }
    }
    
    enum Other {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }
}
