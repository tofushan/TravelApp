//
//  mapViewController.swift
//  the-best-world-traveler
//
//  Created by Yilun Xie on 4/1/21.
//

import UIKit
import MapKit
import FirebaseAuth
import Firebase
import GoogleMapsTileOverlay



class mapViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
    
    // get all the countries in Swift
    //let countries : [ String ] = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
    var countries_to_visit: [String:[String]] = [ : ]
    var countries_visited: [String:[String]] = [ : ]
    let db = Firestore.firestore()
    var dictionary: [Int: Int] = [:]
    var category: Int = 0
    
    
    /*
     This block of code fetch user data
     */
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!

    
    private var boundingRegion: MKCoordinateRegion = MKCoordinateRegion(MKMapRect.world)
    
    override func viewDidLoad() {
        print("map view did load!")
        guard let jsonURL = Bundle.main.url(forResource: "DarkRedBlue", withExtension: "json") else { return }

        let tileOverlay = try? GoogleMapsTileOverlay(jsonURL: jsonURL)
        tileOverlay!.canReplaceMapContent = true
        mapView.addOverlay(tileOverlay as! MKOverlay, level: .aboveRoads)
        
        mapView.delegate = self
        searchBar.delegate = self
        self.displayHome()
        self.fetchTripsFromUser()
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.fetchTripsFromUser()
    }
        
    private func fetchTripsFromUser() {
        // get user ID to store the data
        let userID : String = (Auth.auth().currentUser?.uid)!
        print("userID: \(userID)")
        let userData = db.collection("users").document(userID)
        userData.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("MapView: Document data: \(dataDescription)")
                
                // Look at here for retrieving the user data
                // let email: String = document.get("email") as! String
                // let nickname: String = document.get("nickname") as! String
                
                self.countries_to_visit = document.get("countries_to_visit") as? [String:[String]] ?? [:]
                self.countries_visited = document.get("countries_already_visit") as? [String:[String]] ?? [:]
                
                self.displayAnnotations()
            } else {
                print("Document does not exist")
            }
        }
    }
    
    internal func getFlag(from countryCode: String) -> String {

        return countryCode
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        search(using: searchRequest, cat:3)
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
                        let coordinate_1 = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                        let coordinate_2 = CLLocationCoordinate2D(latitude: 35.994, longitude: -78.8986)
                        var coordinates_1 = [coordinate_1, coordinate_2]
                        let myPolyLine_1: MKPolyline = MKPolyline(coordinates: &coordinates_1, count: coordinates_1.count)
                        self.mapView.addOverlay(myPolyLine_1)
                    
//                        let span = MKCoordinateSpan(latitudeDelta: 60, longitudeDelta: 60)
//                        let region = MKCoordinateRegion(center: location.coordinate, span: span)
//                        self.mapView.setRegion(region, animated: true)
                        
                        // clear existing pins

                        //self.mapView.removeAnnotations(self.mapView.self.annotations)

                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location.coordinate
                        annotation.title = name
                        self.dictionary[annotation.hash] = cat
                        if (cat == 0) {
                            annotation.subtitle = "I plan visit \(name) in the future"
                        } else {
                            annotation.subtitle = "I visited \(name) in the past"
                        }
                        
                        self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let tileOverlay = overlay as? MKTileOverlay {
            return MKTileOverlayRenderer(tileOverlay: tileOverlay)
        }
        // Generate renderer.
        let myPolyLineRendere: MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)
        
        // Specify the thickness of the line.
        myPolyLineRendere.lineWidth = 2
        
        // Specify the color of the line.
        let redValue = CGFloat.random(in: 0...1)
        let greenValue = CGFloat.random(in: 0...1)
        let blueValue = CGFloat.random(in: 0...1)
        myPolyLineRendere.strokeColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 0.7)
        
        return myPolyLineRendere
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotation.title!!)
        if (self.dictionary[annotation.hash] == 3) {
            annotationView.markerTintColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.9)
            annotationView.glyphImage = UIImage(named: "duke")
            return annotationView
        }
        if (self.dictionary[annotation.hash] == 0) {
            annotationView.markerTintColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
        } else if (self.dictionary[annotation.hash] == 1){
            annotationView.markerTintColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
        } else {
            annotationView.markerTintColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.5)
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
        // add countries to visit, change the color to red
        let countries: [String] = Array(self.countries_to_visit.keys)
        for country in countries {
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = country
            search(using: searchRequest, cat:0)
        }
//         add countries visited, change the color to blue
        let visited: [String] = Array(self.countries_visited.keys)
        for country in visited {
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = country
            search(using: searchRequest, cat:1)
        }
    }
    
    private func displayHome() {
        let coordinate = CLLocationCoordinate2D(latitude: 35.994, longitude: -78.8986)
        let annotation = MKPointAnnotation()
        
        let span = MKCoordinateSpan(latitudeDelta: 60, longitudeDelta: 60)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
        
        annotation.coordinate = coordinate
        annotation.title = "Duke"
        self.dictionary[annotation.hash] = 3
        annotation.subtitle = "Let's Go, Duke!"
        self.mapView.addAnnotation(annotation)
    }
    
}


