//
//  SignupVC.swift
//  the-best-world-traveler
//
//  Created by 劉軒甫 on 3/27/21.
//

import UIKit
import FirebaseAuth

class SignupVC: UIViewController {

    @IBOutlet weak var signupEmail: UITextField!
    @IBOutlet weak var signupPassword: UITextField!
    @IBOutlet weak var errors: UILabel!
    
    var emailPlaceholder = NSAttributedString(string: "netid@duke.edu", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    var passwordPlaceholder = NSAttributedString(string: "********", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    
    
    @IBAction func actionSignup(_ sender: Any) {
        // if either email or password is empty, ask for entering
        if signupEmail.text == "" || signupPassword.text == "" {
            errors.text = "Please enter valid email and password"
        }
        else {
            Auth.auth().createUser(withEmail: signupEmail.text!, password: signupPassword.text!, completion: { (result, error) in
                // print out the error on screen if firebase does not like it
                if error != nil {
                    self.errors.text = error?.localizedDescription
                }
                // successfully register!
                else {
                    let alert = UIAlertController(title: "Success", message: "Back to log-in page", preferredStyle: .alert)
                    // pop-up alert bringing user back to log-in page
                    alert.addAction(UIAlertAction(title: "Go Back", style: .default, handler: { (action: UIAlertAction!) in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true)
                    }
                })
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(hue: 0.6, saturation: 0.2, brightness: 1.0, alpha: 1.0)
        errors.text = ""
        signupEmail.attributedPlaceholder = emailPlaceholder
        signupPassword.attributedPlaceholder = passwordPlaceholder
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
