//
//  MapViewController.swift
//  HomeworkWeek-3
//
//  Created by Huseyn Valiyev on 8.07.2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var lastLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkLocationServices()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func showUserLocationMapCenter() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 100, longitudinalMeters: 100)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            trackingLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            break
        case .restricted:
            break
        }
    }
    
    func trackingLocation() {
        mapView.showsUserLocation = true
        showUserLocationMapCenter()
        locationManager.startUpdatingLocation()
        lastLocation = getCenterLocation(map: mapView)
    }
    
    func getCenterLocation(map: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    @IBAction func approveLocation(_ sender: Any) {
        let dataDict: [String: String] = ["data": addressLabel.text!]
        NotificationCenter.default.post(name: .sendLocationNameNotification, object: dataDict, userInfo: dataDict)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        let center = getCenterLocation(map: mapView)
        let geoCoder = CLGeocoder()
        
        guard let lastLocation = lastLocation else { return }
        
        guard center.distance(from: lastLocation) > 30 else { return }
        self.lastLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [ weak self] (placemarks, error) in
            
            guard let self = self else { return }
            
            if let error = error {
                print(error)
                return
            }
            
            guard let placemark = placemarks?.first else { return }
            
            let district = placemark.locality ?? "City"
            let street = placemark.thoroughfare ?? "Street"
            let subStreet = placemark.subLocality ?? "SubStreet"
            let city = placemark.administrativeArea ?? "Administrative Area"
            let subThroughfare = placemark.subThoroughfare ?? "SubThrough"
            
            self.addressLabel.text = "\(city) \(district) \(subStreet) \(street) \(subThroughfare)"
            
        }
        
    }
}
