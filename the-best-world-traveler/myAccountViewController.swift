//
//  myAccountViewController.swift
//  the-best-world-traveler
//
//  Created by Avery Brown II on 4/10/21.
//

import UIKit
import Firebase
import FirebaseAuth

let db = Firestore.firestore()


class myAccountViewController: UIViewController {

    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var name: UITextField!
    
    var tempName: String = ""
    var tempError: String = ""
    
    @IBAction func changeName(_ sender: Any) {
        
        // if either email or password is empty, ask for entering
        if name.text?.count ?? 0 <= 1{
            error.text = "Please enter a name."
        }
        else{
            let userID : String = (Auth.auth().currentUser?.uid)!
        
            let ref = db.collection("users").document(userID)
            ref.updateData([
            "nickname": name.text ?? "Jane Doe"
            ])
            error.text = "Name successfully changed!"
        }
    }
    
    func fetchNickname() {
        // get user ID to store the data
        let userID : String = (Auth.auth().currentUser?.uid)!
        
        let userData = db.collection("users").document(userID)
        userData.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("MapView: Document data: \(dataDescription)")
                
                 let nickname: String = document.get("nickname") as! String
                self.name.text = nickname
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = tempName
        error.text = tempError
        
        self.fetchNickname()

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
