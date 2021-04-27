//
//  helloVC.swift
//  CS207
//
//  Created by Hugh Thomas on 2/3/21.
//

import UIKit

class helloVC: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBAction func button(_ sender: Any) {
        
        // add code here
        // print("Button pressed")
        self.label.text = self.textField.text
        
        self.view.backgroundColor = .blue
    }
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
    }
    

}
