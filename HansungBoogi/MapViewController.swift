//
//  MapViewController.swift
//  HansungBoogi
//
//  Created by kim on 5/21/26.
//

import UIKit
import MapKit

struct SamplePlace {
    let title: String
    let subtitle: String
    let coordinate: CLLocationCoordinate2D
}

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var selectedPlaceTitle: String?
    
    let startCoordinate = CLLocationCoordinate2D(latitude: 37.5823, longitude: 127.0099)
    
    let places: [SamplePlace] = [
        SamplePlace(
            title: "공학관 305호",
            subtitle: "좌측 통로 접근",
            coordinate: CLLocationCoordinate2D(latitude: 37.5821, longitude: 127.0101)
        ),
        SamplePlace(
            title: "상상관 701호",
            subtitle: "우측 통로 접근",
            coordinate: CLLocationCoordinate2D(latitude: 37.5825, longitude: 127.0094)
        ),
        SamplePlace(
            title: "탐구관 B101호",
            subtitle: "양방향 접근 가능",
            coordinate: CLLocationCoordinate2D(latitude: 37.5830, longitude: 127.0108)
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        configureMap()
        addAnnotations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveToSelectedPlaceIfNeeded()
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
    
    private func addAnnotations() {
        for place in places {
            let annotation = MKPointAnnotation()
            annotation.title = place.title
            annotation.subtitle = place.subtitle
            annotation.coordinate = place.coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    private func moveToSelectedPlaceIfNeeded() {
        guard let selectedPlaceTitle else { return }
        
        for annotation in mapView.annotations {
            if let title = annotation.title, title == selectedPlaceTitle {
                let destination = annotation.coordinate
                
                let region = MKCoordinateRegion(
                    center: destination,
                    latitudinalMeters: 300,
                    longitudinalMeters: 300
                )
                
                mapView.setRegion(region, animated: true)
                mapView.selectAnnotation(annotation, animated: true)
                
                drawRoute(to: destination)
                
                // 한 번 처리 후 초기화
                self.selectedPlaceTitle = nil
                break
            }
        }
    }
    
    private func drawRoute(to destination: CLLocationCoordinate2D) {
        // 기존 경로 제거
        mapView.removeOverlays(mapView.overlays)
        
        let coordinates = [startCoordinate, destination]
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(polyline)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .systemBlue  // 색깔
            renderer.lineWidth = 4  // 굵기
            renderer.lineDashPattern = nil   // 점선은 [6, 4]
            return renderer
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
}
