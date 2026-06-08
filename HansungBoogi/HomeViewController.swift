//
//  HomeViewController.swift
//  HansungBoogi
//
//  Created by kim on 5/21/26.
//

import UIKit

class HomeViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var recentButton1: UIButton!
    @IBOutlet weak var recentButton2: UIButton!
    
    let buildings = CampusData.buildings
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "홈"
        
        searchBar.delegate = self
        updateRecentSearchButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateRecentSearchButtons()
    }
    
    @IBAction func recentButtonTapped(_ sender: UIButton) {
        let items = RecentSearchManager.shared.getRecentSearches()
        let selectedIndex = sender == recentButton1 ? 0 : 1
        guard selectedIndex < items.count else { return }
        
        let item = items[selectedIndex]
        if let categoryKeyword = item.categoryKeyword,
           let category = searchCategory(keyword: categoryKeyword) {
            moveToMapTab(category: category, displayName: categoryKeyword)
        } else {
            moveToMapTab(buildingName: item.buildingName, placeName: item.placeName)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !keyword.isEmpty else { return }
        
        if let category = searchCategory(keyword: keyword) {
            let recentItem = RecentSearchItem(buildingName: "", placeName: keyword, categoryKeyword: keyword)
            RecentSearchManager.shared.addRecentSearch(recentItem)
            updateRecentSearchButtons()
            moveToMapTab(category: category, displayName: keyword)
            searchBar.resignFirstResponder()
        } else if let result = searchPlace(keyword: keyword) {
            let recentItem = RecentSearchItem(buildingName: result.buildingName, placeName: result.placeName)
            RecentSearchManager.shared.addRecentSearch(recentItem)
            updateRecentSearchButtons()
            moveToMapTab(buildingName: result.buildingName, placeName: result.placeName)
            searchBar.resignFirstResponder()
        } else {
            showSearchFailAlert()
        }
    }
    
    private func searchCategory(keyword: String) -> PlaceCategory? {
        if keyword == "카페" || keyword == "식당" || keyword == "매점" || keyword == "편의점" {
            return .cafe
        }
        
        return nil
    }
    
    private func searchPlace(keyword: String) -> (buildingName: String, placeName: String)? {
        // 1. "공학관 305호" 같이 입력한 경우
        let components = keyword.split(separator: " ")
        if components.count >= 2 {
            let buildingKeyword = String(components[0])
            let placeKeyword = String(components[1])
            
            if let building = buildings.first(where: { $0.name.contains(buildingKeyword) }),
               let place = building.places.first(where: { $0.name.contains(placeKeyword) }) {
                return (building.name, place.name)
            }
        }
        
        // 2. 건물명만 검색한 경우 → 첫 번째 장소 반환
        if let building = buildings.first(where: { $0.name.contains(keyword) }),
           let firstPlace = building.places.first {
            return (building.name, firstPlace.name)
        }
        
        // 3. 강의실명/시설명만 검색한 경우
        for building in buildings {
            if let place = building.places.first(where: { $0.name.contains(keyword) }) {
                return (building.name, place.name)
            }
        }
        
        return nil
    }
    
    private func updateRecentSearchButtons() {
        let items = RecentSearchManager.shared.getRecentSearches()
        
        let buttons = [recentButton1, recentButton2]
        
        for (index, button) in buttons.enumerated() {
            if index < items.count {
                let item = items[index]
                let title = item.categoryKeyword.map { "\($0) 검색" } ?? "\(item.buildingName) \(item.placeName)"
                button?.setTitle(title, for: .normal)
                button?.isHidden = false
            } else {
                button?.setTitle("", for: .normal)
                button?.isHidden = true
            }
        }
    }
    
    private func moveToMapTab(buildingName: String, placeName: String) {
        guard let tabBarController = self.tabBarController else { return }
        
        if let navigationController = tabBarController.viewControllers?[1] as? UINavigationController,
           let mapViewController = navigationController.viewControllers.first as? MapViewController {
            mapViewController.selectedBuildingName = buildingName
            mapViewController.selectedPlaceName = placeName
            mapViewController.selectedCategory = nil
            mapViewController.selectedCategoryDisplayName = nil
        }
        
        tabBarController.selectedIndex = 1
    }
    
    private func moveToMapTab(category: PlaceCategory, displayName: String) {
        guard let tabBarController = self.tabBarController else { return }
        
        if let navigationController = tabBarController.viewControllers?[1] as? UINavigationController,
           let mapViewController = navigationController.viewControllers.first as? MapViewController {
            mapViewController.selectedBuildingName = nil
            mapViewController.selectedPlaceName = nil
            mapViewController.selectedCategory = category
            mapViewController.selectedCategoryDisplayName = displayName
        }
        
        tabBarController.selectedIndex = 1
    }
    
    private func showSearchFailAlert() {
        let alert = UIAlertController(
            title: "검색 결과 없음",
            message: "일치하는 건물 또는 강의실을 찾을 수 없습니다.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
