//
//  MapViewController.swift
//  HansungBoogi
//
//  Created by kim on 5/21/26.
//

import UIKit
import MapKit

enum PlaceCategory {
    case room
    case cafe
    case office
    case facility
}

enum AccessSide {
    case left
    case right
    case both
}

struct Place {
    let id: Int
    let name: String
    let category: PlaceCategory
    let accessSide: AccessSide
    let guideText: String
}

struct Building {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let places: [Place]
}

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
    
    // 홈 화면에서 전달받을 값
    var selectedBuildingName: String?
    var selectedPlaceName: String?
    
    // 출발지(임시 고정)
    let startCoordinate = CLLocationCoordinate2D(latitude: 37.5823, longitude: 127.0099)
        
    // 건물 데이터
    let buildings: [Building] = [
        Building(
            id: 1,
            name: "공학관",
            latitude: 37.5821,
            longitude: 127.0101,
            places: [
                Place(id: 101, name: "305호", category: .room, accessSide: .left, guideText: "좌측 통로를 이용해 305호 방향으로 이동하세요."),
                Place(id: 102, name: "510호", category: .room, accessSide: .left, guideText: "좌측 계단을 지나 510호로 이동하세요."),
                Place(id: 103, name: "카페", category: .cafe, accessSide: .both, guideText: "1층 중앙 로비 방향으로 이동하세요.")
            ]
        ),
        Building(
            id: 2,
            name: "상상관",
            latitude: 37.5825,
            longitude: 127.0094,
            places: [
                Place(id: 201, name: "701호", category: .room, accessSide: .right, guideText: "우측 복도를 이용해 701호 방향으로 이동하세요."),
                Place(id: 202, name: "스터디라운지", category: .facility, accessSide: .both, guideText: "중앙 엘리베이터 근처에서 접근 가능합니다.")
            ]
        ),
        Building(
                id: 3,
                name: "탐구관",
                latitude: 37.5830,
                longitude: 127.0108,
                places: [
                    Place(id: 301, name: "B101호", category: .room, accessSide: .both, guideText: "중앙 통로를 이용해 B101호로 이동하세요.")
                    ]
                )
            ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        configureMap()
        addBuildingAnnotations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        for building in buildings {
            let annotation = BuildingAnnotation(building: building)
            mapView.addAnnotation(annotation)
        }
    }
    
    private func moveToSelectedBuildingIfNeeded() {
        guard let selectedBuildingName else { return }
        
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
                drawRoute(to: destination)
                
                // 한 번 처리 후 초기화
                self.selectedBuildingName = nil
                break
            }
        }
    }
    
    private func drawRoute(to destination: CLLocationCoordinate2D) {
        mapView.removeOverlays(mapView.overlays)
        
        let coordinates = [startCoordinate, destination]
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(polyline)
    }
    
    // 핀 선택 시 호출
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? BuildingAnnotation else { return }
        
        // 지금은 일단 콘솔 출력만
        print("선택된 건물: \(annotation.building.name)")
        
        if let selectedPlaceName {
            if let matchedPlace = annotation.building.places.first(where: { $0.name == selectedPlaceName }) {
                print("선택된 장소: \(matchedPlace.name)")
                print("안내 문구: \(matchedPlace.guideText)")
                
                // 한 번 처리 후 초기화
                self.selectedPlaceName = nil
            }
        }
    }
    
    // 경로 선 스타일
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            renderer.lineDashPattern = nil   // 점선은 [6, 4]
            return renderer
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
}
