//
//  SelectMapViewController.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 04/09/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SelectMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapAddress: UILabel!
    @IBOutlet weak var pinButton: UIButton!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 500
    var previousLocation:CLLocation?
    var lat:Double?
    var long:Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        checkLocationServices()
        pinButton.littleRoundButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    
    @IBAction func pinTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "backToPickUp", sender: self)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTrackingUserLocation()
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        @unknown default:
            print("Eror")
        }
    }
    
    func startTrackingUserLocation(){
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    func getCenterLocation(for mapView:MKMapView) -> CLLocation{
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        self.lat = latitude
        self.long = longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}

extension SelectMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension SelectMapViewController:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else {return}
        
        guard center.distance(from: previousLocation ) > 10 else {return}
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { (placemarks, error) in
            
            guard let placemark = placemarks?.first else{
                // Informing user
                return
            }
            let name = placemark.locality ?? ""
            let streetName = placemark.thoroughfare ?? ""
            let streetNumber = placemark.subThoroughfare ?? ""
            
            DispatchQueue.main.async {
                self.mapAddress.text = "\(name),\(streetName) \(streetNumber)"
            }
        }
    }

}
