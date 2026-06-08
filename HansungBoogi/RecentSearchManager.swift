//
//  RecentSearchManager.swift
//  HansungBoogi
//
//  Created by kim on 6/8/26.
//

import Foundation

struct RecentSearchItem: Codable, Equatable {
    let buildingName: String
    let placeName: String
    let categoryKeyword: String?
    
    init(buildingName: String, placeName: String, categoryKeyword: String? = nil) {
        self.buildingName = buildingName
        self.placeName = placeName
        self.categoryKeyword = categoryKeyword
    }
}

final class RecentSearchManager {
    static let shared = RecentSearchManager()
    private init() {}
    
    private let key = "recent_search_items"
    
    func getRecentSearches() -> [RecentSearchItem] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let items = try? JSONDecoder().decode([RecentSearchItem].self, from: data) else {
            return []
        }
        return items
    }
    
    func saveRecentSearches(_ items: [RecentSearchItem]) {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func addRecentSearch(_ item: RecentSearchItem) {
        var items = getRecentSearches()
        
        items.removeAll { $0 == item }
        items.insert(item, at: 0)
        
        if items.count > 5 {
            items = Array(items.prefix(5))
        }
        
        saveRecentSearches(items)
    }
    
    func removeAllRecentSearches() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
