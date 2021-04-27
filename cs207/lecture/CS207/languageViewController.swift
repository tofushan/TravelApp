//
//  languageViewController.swift
//  CS207
//
//  Created by Hugh Thomas on 3/12/21.
//

import UIKit

class languageViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.label1.text = NSLocalizedString("NAME", comment: "")
        self.label2.text = NSLocalizedString("AGE", comment: "")
        self.label3.text = NSLocalizedString("COUNTRY", comment: "")
        
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
