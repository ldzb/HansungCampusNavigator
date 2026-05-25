//
//  HomeViewController.swift
//  HansungBoogi
//
//  Created by kim on 5/21/26.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "홈"
    }
    
    @IBAction func recentButtonTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        moveToMapTab(buildingName: "공학관", placeName: "305호")
    }
    
    private func moveToMapTab(buildingName: String, placeName: String) {
        guard let tabBarController = self.tabBarController else { return }
        
        if let navigationController = tabBarController.viewControllers?[1] as? UINavigationController,
           let mapViewController = navigationController.viewControllers.first as? MapViewController {
            mapViewController.selectedBuildingName = buildingName
            mapViewController.selectedPlaceName = placeName
        }
        
        tabBarController.selectedIndex = 1
    }
}
