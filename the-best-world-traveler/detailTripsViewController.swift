//
//  detailTripsViewController.swift
//  the-best-world-traveler
//
//  Created by Christina Le on 4/19/21.
//

import UIKit

class detailTripsViewController: UIViewController {

    @IBOutlet weak var date: UITextView!
    @IBOutlet weak var cities: UITextView!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var country: UILabel!
    
    var tempDate: String = ""
    var tempCities: String = ""
    var tempNotes: String = ""
    var tempCountry: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        date.text = tempDate
        cities.text = tempCities
        notes.text = tempNotes
        country.text = tempCountry
        

        // Do any additional setup after loading the view.
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
