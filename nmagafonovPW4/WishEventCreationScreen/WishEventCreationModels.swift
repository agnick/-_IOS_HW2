//
//  WishEventCreationModels.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 04.12.2024.
//

import Foundation

enum WishEventCreationModel {
    enum Start {
        struct Request {}
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    enum Other {
        struct Request {
            let title: String
            let description: String
            let startDate: Date
            let endDate: Date
        }
        struct Response {
            let success: Bool
            let message: String
        }
        struct ViewModel {
            let success: Bool
            let message: String
        }
    }
}
