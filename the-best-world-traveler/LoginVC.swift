//
//  LoginVC.swift
//  the-best-world-traveler
//
//  Created by Hsuan Fu Liu on 3/27/21.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {

    
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    // these are the paceholders shown in the textfields for guidence
    var emailPlaceholder = NSAttributedString(string: "test@duke.edu", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    var passwordPlaceholder = NSAttributedString(string: "testapp", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    
    @IBOutlet weak var errors: UILabel!
    
    @IBAction func actionLogin(_ sender: Any) {
        // if either email or password is empty, ask for entering
        if inputEmail.text == "" || inputPassword.text == "" {
            errors.text = "Please enter your email and password"
        }
        else {
            // send the inputs to firebase user database
            Auth.auth().signIn(withEmail: self.inputEmail.text!, password: self.inputPassword.text!) { (user, error) in
                
                if error != nil {
                let alert = UIAlertController(title: "Error", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Dismissed", style: .default, handler: nil))
                self.present(alert, animated: true)
                }
                
                else {
                    self.performSegue(withIdentifier: "homeSegue", sender: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup the background color
        self.view.backgroundColor = UIColor.init(hue: 0.1, saturation: 0.4, brightness: 1.0, alpha: 1.0)
        // initialize placeholders and error message
        inputEmail.attributedPlaceholder = emailPlaceholder
        inputPassword.attributedPlaceholder = passwordPlaceholder
        errors.text = ""
        
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
