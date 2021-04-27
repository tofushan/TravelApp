//
//  animalDetailViewController.swift
//  CS207
//
//  Created by Hugh Thomas on 2/5/21.
//

import UIKit

class animalDetailViewController: UIViewController {

    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var animalDesc: UILabel!
    @IBOutlet weak var animalPicture: UIImageView!
    
    var name: String = ""
    var descrip: String = ""
    var picture: UIImage!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        animalName.text = name
        animalDesc.text = descrip
        animalPicture.image = picture
        
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
