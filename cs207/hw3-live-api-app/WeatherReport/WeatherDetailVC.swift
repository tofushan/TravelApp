//
//  WeatherDetailVC.swift
//  WeatherReport
//
//  Created by 劉軒甫 on 2/13/21.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var name: UILabel!
    //@IBOutlet weak var minact: UILabel!
    //@IBOutlet weak var maxact: UILabel!
    @IBOutlet weak var dodge: UILabel!
    @IBOutlet weak var flee: UILabel!
    @IBOutlet weak var capture: UILabel!
    @IBOutlet weak var attack: UILabel!
    
    @IBOutlet weak var pokeImage: UIImageView!
    
    // initailize these var to fetch info from table view
    var pName: String = ""
    var pForm: String = ""
    var pMinAct: Float = 0
    var pMaxAct: Float = 0
    var pDodge : Float = 0
    var pFlee: Float = 0
    var pCapture: Float = 0
    var pAttack: Float = 0
    /*
    var weather_name: String = ""
    var temp_degree: String = ""
    var pic: UIImage! = nil
    */

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = pName
        //minact.text = String(pMinAct)
        //maxact.text = String(pMaxAct)
        attack.text = String(Int(pMaxAct*100)) + " % attack"
        capture.text = String(Int(pAttack*100)) + " % captured"
        flee.text = String(Int(pFlee*100)) + " % escape"
        dodge.text = String(Int(pDodge*100)) + " % dodge"
        
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        switch pForm {
        case "Normal":
            backgroundImage.image = UIImage(named: "Normal")
            
        case "Shadow":
            backgroundImage.image = UIImage(named: "Shadow")
            // set text color to white, as background is blsck
            name.textColor = UIColor.white
            attack.textColor = UIColor.white
            capture.textColor = UIColor.white
            flee.textColor = UIColor.white
            dodge.textColor = UIColor.white
        case "Purified":
            backgroundImage.image = UIImage(named: "Purified")
        default:
            backgroundImage.image = UIImage(named: "Other")
        }
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        

        // Do any additional setup after loading the view.
    }
    
    

    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
    */

}
