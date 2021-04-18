//
//  SignupVC.swift
//  the-best-world-traveler
//
//  Created by Hsuan Fu Liu on 3/27/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage

class SignupVC: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var signupEmail: UITextField!
    @IBOutlet weak var signupPassword: UITextField!
    @IBOutlet weak var errors: UILabel!
    @IBOutlet weak var signupNickname: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var tempAvatar: UIImage = UIImage(named: "default-profile")!
    var image: UIImage? = nil
    var profileImageUrl: String = ""
    
    var emailPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    var passwordPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    var nicknamePlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    
    func setupAvatar(){
        avatar.layer.cornerRadius = 80
        avatar.clipsToBounds = true
        avatar.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        avatar.addGestureRecognizer(tapGesture)
    }
    
    @objc func presentPicker(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func actionSignup(_ sender: Any) {
        
        guard let imageSelected = self.image else{
            print("Avatar is nil")
            return
        }
        
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else{
            return
        }
        
        // if either email or password is empty, ask for entering
        if signupEmail.text == "" || signupPassword.text == "" || signupNickname.text == "" {
            errors.text = "Please enter valid email, password and nickname"
        }
        else if signupNickname.text?.count ?? 0 <= 4 {
            errors.text = "Please enter a valid nickname more than 4 characters"
        }
        else {
            Auth.auth().createUser(withEmail: signupEmail.text!, password: signupPassword.text!, completion: { (result, error) in
                // print out the error on screen if firebase does not like it
                if error != nil {
                    self.errors.text = error?.localizedDescription
                }
                // successfully register!
                else{
                    // add user information to firestore as well for later uses
                    
                    // get user id to get access to user data
                    let userID : String = (Auth.auth().currentUser?.uid)!
                    
                    let storageRef = Storage.storage().reference(forURL: "gs://the-best-world-traveler.appspot.com")
                    let storageProfileRef = storageRef.child("profile").child(userID)
                    
                    let metadata = StorageMetadata()
                    metadata.contentType = "image/jpg"
                    storageProfileRef.putData(imageData, metadata: metadata, completion:
                        { (storageMetaData, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                            return
                        }
                            
                        storageProfileRef.downloadURL(completion: { (url, error) in
                            if let metaImageUrl = url?.absoluteString {
                                print("Hello")
                                print(metaImageUrl)
                                self.profileImageUrl = metaImageUrl
                                let userID : String = (Auth.auth().currentUser?.uid)!
                            
                                let ref = self.db.collection("users").document(userID)
                                ref.updateData([
                                    "profile_image_url": self.profileImageUrl
                                ])
                            }
                        })
                        })
                    
                    self.db.collection("users").document(userID).setData([
                        "email": self.signupEmail.text,
                        "nickname": self.signupNickname.text,
                        "profile_image_url": self.profileImageUrl,
                        "countries_to_visit":[],
                        "countries_already_visit": [],
                        "friends": []
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(userID) ")
                        }
                    }
                    
                    
                    
                    // pop-up alert bringing user back to log-in page
                    let alert = UIAlertController(title: "Success", message: "Back to log-in page", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Go Back", style: .default, handler: { (action: UIAlertAction!) in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true)
                    }
                })
        }
    }
    
    func setupSignUpButton(){
        signUpButton.layer.cornerRadius = 5
        signUpButton.clipsToBounds = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(hue: 0.6, saturation: 0.2, brightness: 1.0, alpha: 1.0)
        self.setupSignUpButton()
        errors.text = ""
        signupEmail.attributedPlaceholder = emailPlaceholder
        signupPassword.attributedPlaceholder = passwordPlaceholder
        signupNickname.attributedPlaceholder = nicknamePlaceholder
        avatar.image = tempAvatar
        
        avatar.layer.borderWidth = 1
        avatar.layer.masksToBounds = false
        avatar.layer.borderColor = UIColor.lightGray.cgColor
        avatar.layer.cornerRadius =  80
        avatar.clipsToBounds = true
        
        self.setupAvatar()
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

extension SignupVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            image = imageSelected
            avatar.image = imageSelected
        }
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            image = imageOriginal
            avatar.image = imageOriginal
        }
    }
}
