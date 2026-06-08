//
//  MapViewController.swift
//  HansungBoogi
//
//  Created by kim on 5/21/26.
//

import UIKit
import MapKit

final class BuildingAnnotation: NSObject, MKAnnotation {
    let building: Building
    var coordinate: CLLocationCoordinate2D
    
    var title: String? {
        building.name
    }
    
    var subtitle: String? {
        "\(building.places.count)개의 장소"
    }
    
    init(building: Building) {
        self.building = building
        self.coordinate = CLLocationCoordinate2D(
            latitude: building.latitude,
            longitude: building.longitude
        )
    }
}

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var infoPanelView: UIView!
    @IBOutlet weak var buildingNameLabel: UILabel!
    @IBOutlet weak var placesLabel: UILabel!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private let resetSearchButton = UIButton(type: .system)
    
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        toggleFavorite()
    }
    
    // 홈 화면에서 전달받을 값
    var selectedBuildingName: String?
    var selectedPlaceName: String?
    var selectedCategory: PlaceCategory?
    var selectedCategoryDisplayName: String?
    
    // 현재 선택 상태
    var currentBuilding: Building?
    var currentPlace: Place?
    
    // 출발지: 한성대 입구(main_gate)
    let startCoordinate = CLLocationCoordinate2D(latitude: 37.58242182870707, longitude: 127.01110631100151)
    
    let buildings = CampusData.buildings
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        configureMap()
        addBuildingAnnotations()
        setupInfoPanel()
        setupResetSearchButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applySelectedCategoryIfNeeded()
        moveToSelectedBuildingIfNeeded()
    }
    
    private func configureMap() {
        let center = CLLocationCoordinate2D(latitude: 37.5825, longitude: 127.0100)
        
        let region = MKCoordinateRegion(
            center: center,
            latitudinalMeters: 800,
            longitudinalMeters: 800
        )
        
        mapView.setRegion(region, animated: false)
    }
    
    private func addBuildingAnnotations() {
        updateBuildingAnnotations(showing: buildings)
    }
    
    private func updateBuildingAnnotations(showing visibleBuildings: [Building]) {
        let buildingAnnotations = mapView.annotations.compactMap { $0 as? BuildingAnnotation }
        mapView.removeAnnotations(buildingAnnotations)
        
        for building in visibleBuildings {
            let annotation = BuildingAnnotation(building: building)
            mapView.addAnnotation(annotation)
        }
    }
    
    private func buildings(containing category: PlaceCategory) -> [Building] {
        buildings.filter { building in
            building.places.contains { place in
                place.category == category
            }
        }
    }
    
    private func setupInfoPanel() {
        infoPanelView.layer.cornerRadius = 16
        infoPanelView.clipsToBounds = true
        
        resetInfoPanelText()
        
        favoriteButton.setTitle("", for: .normal)
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.tintColor = .systemGray
    }
    
    private func setupResetSearchButton() {
        resetSearchButton.setTitle("검색 초기화", for: .normal)
        resetSearchButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        resetSearchButton.tintColor = .systemBlue
        resetSearchButton.backgroundColor = .systemBackground
        resetSearchButton.layer.cornerRadius = 18
        resetSearchButton.layer.shadowColor = UIColor.black.cgColor
        resetSearchButton.layer.shadowOpacity = 0.18
        resetSearchButton.layer.shadowRadius = 6
        resetSearchButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        resetSearchButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        resetSearchButton.isHidden = true
        resetSearchButton.translatesAutoresizingMaskIntoConstraints = false
        resetSearchButton.addTarget(self, action: #selector(resetSearchButtonTapped), for: .touchUpInside)
        
        view.addSubview(resetSearchButton)
        NSLayoutConstraint.activate([
            resetSearchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            resetSearchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func resetInfoPanelText() {
        buildingNameLabel.text = "건물을 선택하세요"
        placesLabel.text = "강의실 및 시설 정보가 여기에 표시됩니다"
        guideLabel.text = "건물 핀을 선택하면 안내 문구가 표시됩니다"
    }
    
    @objc private func resetSearchButtonTapped() {
        selectedBuildingName = nil
        selectedPlaceName = nil
        selectedCategory = nil
        selectedCategoryDisplayName = nil
        currentBuilding = nil
        currentPlace = nil
        
        updateBuildingAnnotations(showing: buildings)
        mapView.removeOverlays(mapView.overlays)
        resetInfoPanelText()
        updateFavoriteButtonAppearance()
        resetSearchButton.isHidden = true
    }
    
    private func updateInfoPanel(for building: Building, selectedPlaceName: String? = nil) {
        currentBuilding = building
        
        buildingNameLabel.text = building.name
        placesLabel.text = building.places.map { $0.name }.joined(separator: " · ")
        
        if let selectedPlaceName,
           let matchedPlace = building.places.first(where: { $0.name == selectedPlaceName }) {
            currentPlace = matchedPlace
            guideLabel.text = matchedPlace.guideText
        } else {
            currentPlace = building.places.first
            guideLabel.text = building.places.first?.guideText ?? "안내 정보가 없습니다."
        }
        
        updateFavoriteButtonAppearance()
    }
    
    private func updateFavoriteButtonAppearance() {
        guard let currentBuilding, let currentPlace else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            favoriteButton.tintColor = .systemGray
            return
        }
        
        let item = FavoriteItem(buildingName: currentBuilding.name, placeName: currentPlace.name)
        let isFavorite = FavoritesManager.shared.isFavorite(item)
        
        let imageName = isFavorite ? "star.fill" : "star"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = isFavorite ? .systemYellow : .systemGray
    }
    
    private func toggleFavorite() {
        guard let currentBuilding, let currentPlace else {
            guideLabel.text = "선택된 장소가 없습니다."
            return
        }
        
        let item = FavoriteItem(buildingName: currentBuilding.name, placeName: currentPlace.name)
        
        if FavoritesManager.shared.isFavorite(item) {
            FavoritesManager.shared.removeFavorite(item)
        } else {
            FavoritesManager.shared.addFavorite(item)
        }
        
        updateFavoriteButtonAppearance()
    }
    
    private func applySelectedCategoryIfNeeded() {
        guard let selectedCategory else { return }
        
        let filteredBuildings = buildings(containing: selectedCategory)
        updateBuildingAnnotations(showing: filteredBuildings)
        mapView.removeOverlays(mapView.overlays)
        
        let displayName = selectedCategoryDisplayName ?? "검색"
        buildingNameLabel.text = "\(displayName) 검색 결과"
        placesLabel.text = "\(displayName)이 있는 건물만 지도에 표시됩니다"
        guideLabel.text = "원하는 건물 핀을 선택하세요"
        currentBuilding = nil
        currentPlace = nil
        updateFavoriteButtonAppearance()
        resetSearchButton.isHidden = false
        
        self.selectedCategory = nil
        self.selectedCategoryDisplayName = nil
    }
    
    private func moveToSelectedBuildingIfNeeded() {
        guard let selectedBuildingName else { return }
        
        updateBuildingAnnotations(showing: buildings)
        resetSearchButton.isHidden = true
        
        for annotation in mapView.annotations {
            guard let buildingAnnotation = annotation as? BuildingAnnotation else { continue }
            
            if buildingAnnotation.building.name == selectedBuildingName {
                let destination = buildingAnnotation.coordinate
                
                let region = MKCoordinateRegion(
                    center: destination,
                    latitudinalMeters: 300,
                    longitudinalMeters: 300
                )
                
                mapView.setRegion(region, animated: true)
                mapView.selectAnnotation(buildingAnnotation, animated: true)
                updateInfoPanel(for: buildingAnnotation.building, selectedPlaceName: selectedPlaceName)
                drawRoute(to: buildingAnnotation.building)
                
                self.selectedBuildingName = nil
                self.selectedPlaceName = nil
                break
            }
        }
    }
    
    private func drawRoute(to building: Building) {
        mapView.removeOverlays(mapView.overlays)
        
        let coordinates = CampusPathData.pathCoordinates(toBuildingName: building.name) ?? [
            startCoordinate,
            CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude)
        ]
        
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(polyline)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? BuildingAnnotation else { return }
        updateInfoPanel(for: annotation.building, selectedPlaceName: selectedPlaceName)
        drawRoute(to: annotation.building)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            renderer.lineDashPattern = nil
            return renderer
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
}
