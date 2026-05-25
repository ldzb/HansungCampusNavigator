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
        moveToMapTab(placeTitle: title)
    }
    
    private func moveToMapTab(placeTitle: String) {
        guard let tabBarController = self.tabBarController else { return }
        
        if let navigationController = tabBarController.viewControllers?[1] as? UINavigationController,
           let mapViewController = navigationController.viewControllers.first as? MapViewController {
            mapViewController.selectedPlaceTitle = placeTitle
        }
        
        tabBarController.selectedIndex = 1
    }
}
