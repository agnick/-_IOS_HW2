//
//  WishStoringModels.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 03.12.2024.
//

enum WishStoringModel {
    enum Start {
        struct Request {}
        struct Response {
            let wishes: [String]
        }
        struct ViewModel {
            let wishes: [String]
        }
    }
    
    enum AddWish {
        struct Request {
            let wish: String
        }
    }
    
    enum DeleteWish {
        struct Request {
            let index: Int
        }
    }
    
    enum EditWish {
        struct Request {
            let index: Int
            let wish: String
        }
    }
}
