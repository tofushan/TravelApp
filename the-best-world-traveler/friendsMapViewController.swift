//
//  friendsMapViewController.swift
//  the-best-world-traveler
//
//  Created by Yilun Xie on 4/18/21.
//

import UIKit
import MapKit
import GoogleMapsTileOverlay

class friendsMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var friend_email: String!
    var countries_to_visit: [String:[String]]?!
    var countries_visited: [String:[String]]?!
    
    var trip: [String]!
    var dictionary: [Int: Int] = [:]
    var category: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let jsonURL = Bundle.main.url(forResource: "DarkRedBlue", withExtension: "json") else { return }

        let tileOverlay = try? GoogleMapsTileOverlay(jsonURL: jsonURL)
        tileOverlay!.canReplaceMapContent = true
        mapView.addOverlay(tileOverlay as! MKOverlay, level: .aboveRoads)
        
        mapView.delegate = self
        self.displayAnnotations()
        // Do any additional setup after loading the view.
    }
    
    internal func getFlag(from countryCode: String) -> String {

        return countryCode
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
    
    private func search(using searchRequest: MKLocalSearch.Request, cat: Int) {
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else {
                return
            }
            
            for item in response.mapItems {

                if let name = item.name,
                    let location = item.placemark.location {
                        print("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
                        //self.mapView.removeAnnotations(self.mapView.self.annotations)

                    
                        let span = MKCoordinateSpan(latitudeDelta: 60, longitudeDelta: 60)
                        let region = MKCoordinateRegion(center: location.coordinate, span: span)
                        self.mapView.setRegion(region, animated: true)
                        
                        // clear existing pins

                        //self.mapView.removeAnnotations(self.mapView.self.annotations)

                        let annotation = MKPointAnnotation()
                        self.dictionary[annotation.hash] = cat
                        annotation.coordinate = location.coordinate
                        annotation.title = name
                        if (cat == 0) {
                            annotation.subtitle = "\(String(self.friend_email)) plan to visit \(name)"
                        } else {
                            annotation.subtitle = "\(String(self.friend_email)) visited \(name)"
                        }
                        
                        self.mapView.addAnnotation(annotation)
                    
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotation.title!!)
//        let redValue = CGFloat.random(in: 0...1)
//        let greenValue = CGFloat.random(in: 0...1)
//        let blueValue = CGFloat.random(in: 0...1)
//        annotationView.markerTintColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        if (self.dictionary[annotation.hash] == 0) {
            annotationView.markerTintColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
        } else {
            annotationView.markerTintColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)

        }
                
        let locale = Locale(identifier: "en_US")
        let countryCode = locale.countryCode(by: annotation.title!!)
        annotationView.glyphText = getFlag(from: countryCode ?? "US")
        
        // detail button on right side of the callout
        let btn = UIButton(type: .detailDisclosure)
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = btn
        
        // flag on left side of the callout
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        label.text = getFlag(from: countryCode ?? "US")
        annotationView.leftCalloutAccessoryView = label
        // detail callout
        //annotationView.detailCalloutAccessoryView = UIImageView(image: #imageLiteral(resourceName: "plane.png"))
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let annotation = view.annotation
        
        let locale = Locale(identifier: "en_US")
        let countryCode = locale.countryCode(by: (annotation?.title!!)!)
        
        
        let placeName = annotation?.title
        let placeInfo = getFlag(from: countryCode ?? "US") + (annotation?.subtitle)!!

        let ac = UIAlertController(title: placeName!!, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    private func displayAnnotations() {
        // add countries to visit
        self.category = 0
        self.trip = Array(self.countries_to_visit!.keys)
        for country in trip {
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = country
            search(using: searchRequest, cat:0)
        }
        // add countries visited, change the color to blue
        self.category = 1
        self.trip = Array(self.countries_visited!.keys)
        for country in trip {
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = country
            search(using: searchRequest, cat:1)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let tileOverlay = overlay as? MKTileOverlay {
            return MKTileOverlayRenderer(tileOverlay: tileOverlay)
        }
        
        return MKOverlayRenderer(overlay: overlay)
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
