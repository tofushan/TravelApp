//
//  mapViewController.swift
//  the-best-world-traveler
//
//  Created by Yilun Xie on 4/1/21.
//

import UIKit
import MapKit

class mapViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
    
    // get all the countries in Swift
    //let countries : [ String ] = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
    let countries: [String] = ["United States", "Canada", "Mexico"]
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var boundingRegion: MKCoordinateRegion = MKCoordinateRegion(MKMapRect.world)
    override func viewDidLoad() {
        super.viewDidLoad()
        print(countries)
        self.displayAnnotations()
        mapView.delegate = self
        searchBar.delegate = self
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
        search(using: searchRequest)
    }
    
    private func search(using searchRequest: MKLocalSearch.Request) {
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

                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location.coordinate
                        annotation.title = name
                        self.mapView.addAnnotation(annotation)
                    
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MyMarker")
        let redValue = CGFloat.random(in: 0...1)
        let greenValue = CGFloat.random(in: 0...1)
        let blueValue = CGFloat.random(in: 0...1)
        annotationView.markerTintColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        let locale = Locale(identifier: "en_US")
        let countryCode = locale.countryCode(by: annotation.title!!)
        annotationView.glyphText = getFlag(from: countryCode ?? "US")
        
        return annotationView
    }
    
    private func displayAnnotations() {
        for country in self.countries {
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = country
            search(using: searchRequest)
        }
    }
    
}
