//
//  TripsViewController.swift
//  semana7
//
//  Created by MAC07 on 25/11/21.
//

import UIKit
import MapKit
import CoreLocation

class TripsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    let placeViewModel = PlaceViewModel()
        
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocation()
        configure()
        bind()
        configureStyleView()
        
    }
    
    func requestLocation() {
        guard CLLocationManager.locationServicesEnabled() else { return }
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()

        mapView.delegate = self
         
    }
    
    func configure() {
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(getPointFromMap(longGesture: )))
        mapView.addGestureRecognizer(longGesture)
        placeViewModel.getPlaces()
    }
    
    func bind() {
        placeViewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.createAnnotation()
            }
        }
    }
    
    func configureStyleView() {
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.isHidden = true
    }
    
    @objc func getPointFromMap(longGesture: UIGestureRecognizer) {
        let touchPoint = longGesture.location(in: mapView)
        let coordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        setAnnotation(coodinates: coordinates, title: "Get Point", subtitle: "\(coordinates.latitude) - \(coordinates.longitude)")
    }


}


extension TripsViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let bestLocation = locations.last else { return }
        
        print(bestLocation.coordinate.latitude)
        print(bestLocation.coordinate.longitude)
        let localValue: CLLocationCoordinate2D = manager.location!.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: localValue, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    

    func createAnnotation() {
         let places = placeViewModel.arrayResults
        
        for place in places {
            let coordinates = CLLocationCoordinate2D(latitude: Double(place.latitude)!, longitude:  Double(place.longitude)!)
            setAnnotation(coodinates: coordinates, title: place.name, subtitle: "\(place.rating)")
        }
    }
  
    func setAnnotation(coodinates: CLLocationCoordinate2D, title: String, subtitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coodinates
        annotation.title = title
        annotation.subtitle = subtitle
        mapView.addAnnotation(annotation)
    }
    
}

extension TripsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.contentView.isHidden = false
        self.lblName.text = (view.annotation?.title)!
        self.lblRating.text = (view.annotation?.subtitle)!
    }
    
}
