//
//  WishStoringProtocols.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 03.12.2024.
//

protocol WishStoringBusinessLogic {
    func loadWishes(_ request: WishStoringModel.Start.Request)
    func addWish(_ request: WishStoringModel.AddWish.Request)
    func deleteWish(_ request: WishStoringModel.DeleteWish.Request)
    func editWish(_ request: WishStoringModel.EditWish.Request)
}

protocol WishStoringPresentationLogic {
    func presentWishes(_ response: WishStoringModel.Start.Response)
}
