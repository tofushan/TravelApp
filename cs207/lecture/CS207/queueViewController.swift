//
//  queueViewController.swift
//  CS207
//
//  Created by Hugh Thomas on 2/12/21.
//

import UIKit

class queueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let queue = DispatchQueue(label: "edu.duke.myqueue", qos: DispatchQoS.userInteractive)
        
        queue.async {
            
            var j = 0
            for k in 0...10 {
//                for i in 0...1000000 {
//                    j = j+1
//                }
            
                print("Hello world from user queue")
            }
            
        }
        
        let queue2 = DispatchQueue(label: "edu.duke.myqueue", qos: DispatchQoS.utility)
        
        queue2.async {
            var j = 0
            for k in 0...10 {
//                for i in 0...1000000 {
//                    j = j+1
//                }
            
              print("I'm back on utility queue")
            }
        }
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
