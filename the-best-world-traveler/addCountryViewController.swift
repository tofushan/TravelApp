//
//  addCountryViewController.swift
//  the-best-world-traveler
//
//  Created by Jaylyn Barbee on 4/4/21.
//  Edited by Christina Le on 4/17/21.

import UIKit
import Firebase
import FirebaseAuth

class addCountryViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var notesBox: UITextView!
    
    @IBOutlet weak var arrivalDate: UIDatePicker!
    @IBOutlet weak var departureDate: UIDatePicker!
    
    @IBOutlet weak var visitedButton: UIButton!
    @IBOutlet weak var toVisitButton: UIButton!

    
    var country: String = ""
    var countryVisited: Bool = true
    var countryToVisit: Bool = false
    var cities: String = ""
    
    let db = Firestore.firestore()
    
   
    @IBAction func clickVisited(_ sender: UIButton) {
        deselectAllButtons()
        visitedButton.isSelected = true
        countryVisited = true
        countryToVisit = false
    }
    
    @IBAction func clickToVisit(_ sender: UIButton) {
        deselectAllButtons()
        toVisitButton.isSelected = true
        countryVisited = false
        countryToVisit = true
    }
    
    
    func deselectAllButtons(){
        for subView in view.subviews
          {
            // Set all the other buttons as normal state
            if let button = subView as? UIButton {
                button.isSelected = false
            }
        }
       //Or you can simply do write above for loop code with one line
      /*
       view.subviews.forEach { ($0 as? UIButton)?.isSelected = false }
      */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = backButton
        
        let saveButton: UIBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(add))
        self.navigationItem.rightBarButtonItem = saveButton
        
        self.navigationItem.title = country
        
        searchBar.delegate = self
        
        self.notesBox.layer.borderColor = UIColor.lightGray.cgColor
        self.notesBox.layer.borderWidth = 1
        
        //add()
    }
    
  

    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func add(){
        
        // data to store
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let a_year: String = dateFormatter.string(from: self.arrivalDate.date)
        dateFormatter.dateFormat = "MM"
        let a_month: String = dateFormatter.string(from: self.arrivalDate.date)
        dateFormatter.dateFormat = "dd"
        let a_day: String = dateFormatter.string(from: self.arrivalDate.date)
        
        dateFormatter.dateFormat = "yyyy"
        let d_year: String = dateFormatter.string(from: self.departureDate.date)
        dateFormatter.dateFormat = "MM"
        let d_month: String = dateFormatter.string(from: self.departureDate.date)
        dateFormatter.dateFormat = "dd"
        let d_day: String = dateFormatter.string(from: self.departureDate.date)
        
        let arrive: String = a_month + "/" + a_day + "/" + a_year
        let depart: String = d_month + "/" + d_day + "/" + d_year
        
        let notes: String = notesBox.text
        
        // get user ID to store the data
        let userID : String = (Auth.auth().currentUser?.uid)!
        //print("Current user ID is = " + userID)
        
        // get the reference which the user data point to
        
        if countryVisited == true{
            let userData = db.collection("users").document(userID).updateData([
                // store data like: "countries_to_visit.United State" : [ "date", "cities", "notes" ]
                // TODO: please enter the information in the list
                
                "countries_already_visit" + "." + country : [ depart + " - " + arrive, self.cities, notes ],
            ])
            { err in
            if let err = err {
                print("Error updating document: \(err)")
                let alert = UIAlertController(title: "Error", message: "\(err)", preferredStyle: .alert)
            
                alert.addAction(UIAlertAction(title: "Dismissed", style: .default, handler: nil))
                self.present(alert, animated: true)
            } else {
                print("Document successfully updated")
                let alert = UIAlertController(title: "Success", message: "Travel plan for country already visited successfully added", preferredStyle: .alert)
            
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
        }
        else {
            let userData = db.collection("users").document(userID).updateData([
                // store data like: "countries_to_visit.United State" : [ "date", "cities", "notes" ]
                // TODO: please enter the information in the list
                
                "countries_to_visit" + "." + country : [ depart + " - " + arrive, self.cities, notes ],
            ])
            { err in
            if let err = err {
                print("Error updating document: \(err)")
                let alert = UIAlertController(title: "Error", message: "\(err)", preferredStyle: .alert)
            
                alert.addAction(UIAlertAction(title: "Dismissed", style: .default, handler: nil))
                self.present(alert, animated: true)
            } else {
                print("Document successfully updated")
                let alert = UIAlertController(title: "Success", message: "Travel plan for future country to visit successfully added", preferredStyle: .alert)
            
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
        }
        
        self.dismiss(animated: true, completion: nil)

        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let CVC = children.last as! addedCityTableViewController

        CVC.changeData(data: searchBar.text!)
        self.cities = self.cities + searchBar.text! + ", "
        
        print("searchText \(searchBar.text ?? "")")
    }

    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cvc = segue.destination as! addedCityTableViewController

    }
    */
    
    
    

}
