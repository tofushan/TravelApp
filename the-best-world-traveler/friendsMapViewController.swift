//
//  friendsMapViewController.swift
//  the-best-world-traveler
//
//  Created by Yilun Xie on 4/18/21.
//

import UIKit
import MapKit

class friendsMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var trip: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        self.displayAnnotations()
        // Do any additional setup after loading the view.
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

                        //self.mapView.removeAnnotations(self.mapView.self.annotations)

                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location.coordinate
                        annotation.title = name
                        annotation.subtitle = "I visited \(name) on (date)"
                        self.mapView.addAnnotation(annotation)
                    
                }
            }
        }
    }
    
    private func displayAnnotations() {
        // add countries to visit, change the color to yellow
        for country in trip {
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = country
            search(using: searchRequest)
        }
        // add countries visited, change the color to blue
//        self.category = 1
//        let visited: [String] = Array(self.countries_visited.keys)
//        for country in visited {
//            let searchRequest = MKLocalSearch.Request()
//            searchRequest.naturalLanguageQuery = country
//            search(using: searchRequest)
//        }
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
