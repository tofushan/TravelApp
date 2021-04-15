//
//  SecurityVC.swift
//  the-best-world-traveler
//
//  Created by Hsuan Fu Liu on 4/15/21.
//

import UIKit
import Firebase
import FirebaseAuth

class SecurityVC: UIViewController {
    
    @IBAction func sendEmailForChaningPassword(_ sender: Any) {
        
        var userEmail: String! = ""
        // check if user log in already
        if Auth.auth().currentUser != nil {
            userEmail = Auth.auth().currentUser?.email
        }
        
        
        // send email for reseting password
        Auth.auth().sendPasswordReset(withEmail: userEmail ) { error in
            if error != nil {
                let alert = UIAlertController(title: "Unable to send email", message: "\(String(describing: error))", preferredStyle: .alert)
            
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            else {
                let alert = UIAlertController(title: "Email sent successfully", message: "Please check your mail box to reset password", preferredStyle: .alert)
            
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
 
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
