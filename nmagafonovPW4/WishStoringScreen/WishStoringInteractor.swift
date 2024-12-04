//
//  WishStoringInteractor.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 03.12.2024.
//

final class WishStoringInteractor: WishStoringBusinessLogic {
    private let presenter: WishStoringPresentationLogic
    private let worker = WishStoringWorker()
    
    init(presenter: WishStoringPresentationLogic) {
        self.presenter = presenter
    }
    
    func loadWishes(_ request: WishStoringModel.Start.Request) {
        let wishes = worker.fetchWishes()
        presenter.presentWishes(WishStoringModel.Start.Response(wishes: wishes))
    }
    
    func addWish(_ request: WishStoringModel.AddWish.Request) {
        worker.addWish(request.wish)
        loadWishes(WishStoringModel.Start.Request())
    }
    
    func deleteWish(_ request: WishStoringModel.DeleteWish.Request) {
        worker.deleteWish(at: request.index)
        loadWishes(WishStoringModel.Start.Request())
    }
    
    func editWish(_ request: WishStoringModel.EditWish.Request) {
        worker.editWish(at: request.index, with: request.wish)
        loadWishes(WishStoringModel.Start.Request())
    }
}
