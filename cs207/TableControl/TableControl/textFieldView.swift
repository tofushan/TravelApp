//
//  textFieldView.swift
//  TableControl
//
//  Created by 劉軒甫 on 2/6/21.
//

import UIKit

class textFieldView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var label: UILabel!
    
    
    
    @IBAction func buttom(_ sender: Any) {
        self.label.text = self.textField.text
        self.view.backgroundColor = .black
    }
    @IBOutlet weak var textField: UITextField!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
