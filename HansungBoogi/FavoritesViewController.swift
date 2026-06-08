import UIKit

class FavoritesViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var favorites: [FavoriteItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "즐겨찾기"
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favorites = FavoritesManager.shared.getFavorites()
        tableView.reloadData()
        updateEmptyState()
    }
    
    private func updateEmptyState() {
        if favorites.isEmpty {
            let label = UILabel()
            label.text = "즐겨찾기된 장소가 없습니다"
            label.textAlignment = .center
            label.textColor = .gray
            label.numberOfLines = 0
            tableView.backgroundView = label
        } else {
            tableView.backgroundView = nil
        }
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

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
        
        let item = favorites[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = "\(item.buildingName) \(item.placeName)"
        content.secondaryText = "저장된 즐겨찾기"
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = favorites[indexPath.row]
        moveToMapTab(buildingName: item.buildingName, placeName: item.placeName)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = favorites[indexPath.row]
            FavoritesManager.shared.removeFavorite(item)
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            updateEmptyState()
        }
    }
}
