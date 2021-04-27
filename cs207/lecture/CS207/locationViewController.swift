//
//  locationViewController.swift
//  CS207
//
//  Created by Hugh Thomas on 2/24/21.
//

import UIKit
import CoreLocation
import MapKit
import MBProgressHUD


class locationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showHUD()
        
        locationManager.delegate = self
        mapView.delegate = self
        
        
        // Do any additional setup after loading the view.
        locationManager.requestWhenInUseAuthorization()
        
        let quadCorners = [CLLocationCoordinate2D(latitude: 36.002972,
                                                  longitude: -78.937350),
                           CLLocationCoordinate2D(latitude: 36.002846,
                               longitude: -78.936937),
                           CLLocationCoordinate2D(latitude: 35.999092,
                               longitude: -78.939507),
                           CLLocationCoordinate2D(latitude: 35.999292,
                               longitude: -78.939974),
                           CLLocationCoordinate2D(latitude: 36.000900,
                               longitude: -78.938859),
                           CLLocationCoordinate2D(latitude: 36.001445,
                               longitude: -78.939936),
                           CLLocationCoordinate2D(latitude: 36.001946,
                               longitude: -78.939638),
                           CLLocationCoordinate2D(latitude: 36.001492,
                               longitude: -78.938459),
                           CLLocationCoordinate2D(latitude: 36.002972, longitude: -78.937350)]
        
        let chapelCoords = CLLocationCoordinate2D(latitude: 36.001678,
            longitude: -78.939767)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: chapelCoords, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = chapelCoords
        annotation.title = "Duke Chapel"
        annotation.subtitle = "West Campus"
        
        mapView.addAnnotation(annotation)
        
        let polyline = MKPolyline(coordinates: quadCorners, count: quadCorners.count)
        mapView.addOverlay(polyline)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.showHUD()
        sleep(2)
        self.hideLoadingHUD()
    }
    
    // MARK: Pod example
    
    func showHUD() {
        let wheel = MBProgressHUD.showAdded(to: self.view, animated: true)
        wheel.label.text = "Loading..."
    }
    
    func hideLoadingHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
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
        
        locationManager.stopUpdatingLocation()
        
    }
    
    //MARK: Mapkit Delegate methods
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = UIColor.blue.withAlphaComponent(0.8)
            renderer.lineWidth = 5
            return renderer
        }

        return MKOverlayRenderer()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
