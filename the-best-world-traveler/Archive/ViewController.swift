//
//  ViewController.swift
//  the-best-world-traveler
//
//  Created by 劉軒甫 on 3/25/21.
//

import UIKit
import MapKit
import CoreLocation

protocol HandleMapSearch {
    func dropPin(placemark:MKPlacemark)
}


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var locationSearchController:UISearchController? = nil
    var locationManager = CLLocationManager()
    var selectedPin:MKPlacemark? = nil

    
    @IBOutlet weak var mapView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self

        // Do any additional setup after loading the view.
        
        locationManager.requestWhenInUseAuthorization()
        
        let locationTableViewController = storyboard!.instantiateViewController(withIdentifier: "locationTableViewController") as! locationTableViewController
        
        locationSearchController = UISearchController(searchResultsController: locationTableViewController)
        
        locationSearchController?.searchResultsUpdater = locationTableViewController
    
        let searchBar = locationSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        navigationItem.titleView = locationSearchController?.searchBar
        
        locationSearchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        locationTableViewController.mapView = mapView
        
        locationTableViewController.handleMapSearchDelegate = self

    
    }

    
    // MARK: CoreLocation Methods
        
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            print("App is authorized")
            locationManager.startUpdatingLocation()
        }
        
        if status == .notDetermined || status == .denied {
            locationManager.requestWhenInUseAuthorization()
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //print("Location \(locations.first)")
        print("Latitude = \(locations.first!.coordinate.latitude)")
        print("Longitude = \(locations.first!.coordinate.longitude)")
        
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                mapView.setRegion(region, animated: true)
            }
        
        locationManager.stopUpdatingLocation()
        
    }
}

extension ViewController: HandleMapSearch {
    func dropPin(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let locality = placemark.locality,
        let area = placemark.administrativeArea {
            annotation.subtitle = "\(locality) \(area)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

