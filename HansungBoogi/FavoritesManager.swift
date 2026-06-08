//
//  FavoritesManager.swift
//  HansungBoogi
//
//  Created by kim on 6/8/26.
//

import Foundation

struct FavoriteItem: Codable, Equatable {
    let buildingName: String
    let placeName: String
}

final class FavoritesManager {
    static let shared = FavoritesManager()
    private init() {}
    
    private let key = "favorite_items"
    
    func getFavorites() -> [FavoriteItem] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let favorites = try? JSONDecoder().decode([FavoriteItem].self, from: data) else {
            return []
        }
        return favorites
    }
    
    func saveFavorites(_ favorites: [FavoriteItem]) {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func addFavorite(_ item: FavoriteItem) {
        var favorites = getFavorites()
        if !favorites.contains(item) {
            favorites.append(item)
            saveFavorites(favorites)
        }
    }
    
    func removeFavorite(_ item: FavoriteItem) {
        var favorites = getFavorites()
        favorites.removeAll { $0 == item }
        saveFavorites(favorites)
    }
    
    func isFavorite(_ item: FavoriteItem) -> Bool {
        return getFavorites().contains(item)
    }
    
    func removeAllFavorites() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
