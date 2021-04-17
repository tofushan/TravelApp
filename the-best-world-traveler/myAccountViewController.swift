//
//  myAccountViewController.swift
//  the-best-world-traveler
//
//  Created by Christina Le on 4/17/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import SDWebImage
import FirebaseUI

let db = Firestore.firestore()

class myAccountViewController: UIViewController {

    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var saveAvatar: UIButton!
    @IBOutlet weak var saveName: UIButton!
    
    var tempName: String = ""
    var tempError: String = ""
    var tempAvatar: UIImage = UIImage(named: "default-profile")!
    var image: UIImage? = nil
    
    @IBAction func saveNewAvatar(_ sender: Any){
        guard let imageSelected = self.image else{
            print("Avatar is nil")
            return
        }
        
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else{
            return
        }
        
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
                    let userID : String = (Auth.auth().currentUser?.uid)!
                
                    let ref = db.collection("users").document(userID)
                    ref.updateData([
                        "profile_image_url": metaImageUrl
                    ])
                    let storageRef = Storage.storage().reference(forURL: metaImageUrl)
                    SDImageCache.shared.clearMemory()
                    SDImageCache.shared.clearDisk()
                    self.avatar.sd_setImage(with: storageRef, placeholderImage: UIImage(named: "default-profile.png"))
                }
            })
            })
        
        
    }
    
    @IBAction func changeName(_ sender: Any) {
        
        // if either email or password is empty, ask for entering
        if name.text?.count ?? 0 < 1{
            error.text = "Please enter a name."
        }
        else{
            let userID : String = (Auth.auth().currentUser?.uid)!
        
            let ref = db.collection("users").document(userID)
            ref.updateData([
            "nickname": name.text ?? "Jane Doe"
            ])
            error.text = ""
        }
    }
    
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
    
    func fetchData() {
        // get user ID to store the data
        let userID : String = (Auth.auth().currentUser?.uid)!
        
        let userData = db.collection("users").document(userID)
        userData.getDocument { (document, error) in
            if let document = document, document.exists {
                let profileImageUrl: String = document.get("profile_image_url") as! String
                if profileImageUrl != ""{
                    let storageRef = Storage.storage().reference(forURL: profileImageUrl)
                    SDImageCache.shared.clearMemory()
                    SDImageCache.shared.clearDisk()
                    self.avatar.sd_setImage(with: storageRef, placeholderImage: UIImage(named: "default-profile.png"))
                }
                let nickname: String = document.get("nickname") as! String
                self.name.text = nickname
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func setupButtons(){
        saveAvatar.layer.cornerRadius = 5
        saveAvatar.clipsToBounds = true
        saveName.layer.cornerRadius = 5
        saveName.clipsToBounds = true
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = tempName
        error.text = tempError
        avatar.image = tempAvatar
        
        avatar.layer.borderWidth = 1
        avatar.layer.masksToBounds = false
        avatar.layer.borderColor = UIColor.lightGray.cgColor
        avatar.layer.cornerRadius =  80
        avatar.clipsToBounds = true
        
        self.setupAvatar()
        self.setupButtons()
        
        self.fetchData()

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

extension myAccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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
