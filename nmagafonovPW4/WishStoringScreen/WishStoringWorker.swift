//
//  WishStoringWorker.swift
//  nmagafonovPW4
//
//  Created by Никита Агафонов on 04.12.2024.
//

import Foundation

final class WishStoringWorker {
    private let userDefaultsKey = "wishes"

    func fetchWishes() -> [String] {
        return UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] ?? []
    }

    func addWish(_ wish: String) {
        var wishes = fetchWishes()
        wishes.append(wish)
        UserDefaults.standard.set(wishes, forKey: userDefaultsKey)
    }

    func deleteWish(at index: Int) {
        var wishes = fetchWishes()
        wishes.remove(at: index)
        UserDefaults.standard.set(wishes, forKey: userDefaultsKey)
    }

    func editWish(at index: Int, with wish: String) {
        var wishes = fetchWishes()
        wishes[index] = wish
        UserDefaults.standard.set(wishes, forKey: userDefaultsKey)
    }
}
