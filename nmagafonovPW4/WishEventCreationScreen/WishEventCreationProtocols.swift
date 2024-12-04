//
//  WishEventCreationProtocols.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 04.12.2024.
//

protocol WishEventCreationBusinessLogic {
    func loadStart(_ request: WishEventCreationModel.Start.Request)
    func loadOther(_ request: WishEventCreationModel.Other.Request)
}

protocol WishEventCreationPresentationLogic {
    func presentStart(_ response: WishEventCreationModel.Start.Response)
    func presentOther(_ response: WishEventCreationModel.Other.Response)
    
    func routeTo()
}
