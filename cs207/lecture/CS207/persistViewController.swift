//
//  persistViewController.swift
//  CS207
//
//  Created by Hugh Thomas on 3/5/21.
//

import UIKit

class persistViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        defaults.set(25, forKey: "Age")
        defaults.set("Professor Thomas", forKey: "CS207Lecturer")
        defaults.set(true, forKey: "hw3IsComplete")
        
        let lecturerName = defaults.string(forKey: "CS207Lecturer")
        print("Lecturer of CompSci207 is \(lecturerName)")
        
        let isComplete = defaults.bool(forKey: "hw3IsComplete")
        isComplete ? print("HW3 is Done") : print("HW3 is late")
        
        let myAge = defaults.integer(forKey: "Age")
        print("I am \(myAge) years old")
        
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
