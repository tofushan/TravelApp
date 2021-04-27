//
//  simpleNetworkViewController.swift
//  CS207
//
//  Created by Hugh Thomas on 2/17/21.
//

import UIKit

class simpleNetworkViewController: UIViewController {

    struct todoItem: Decodable {
        var userId:Int
        var id:Int
        var title:String
        var completed:Bool
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Simple Network example")
        
        let mySession = URLSession(configuration: URLSessionConfiguration.default)
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
        
        let task = mySession.dataTask(with: url) { data, response, error in
            
            // ensure there is no error for this HTTP response
            guard error == nil else {
                print ("Error: \(error!)")
                DispatchQueue.main.async {
                
                    let alert = UIAlertController(title: "Error - ", message: "\(error!)", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                }
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let jsonData = data else {
                print("No data")
                return
            }
            
            do {
                let allTodos = try JSONDecoder().decode([todoItem].self, from: jsonData)
                
                for todo in allTodos {
                    print("UserId: \(todo.userId)")
                    print("This Id: \(todo.id)")
                    print("Title: \(todo.title)")
                    if (todo.completed) {
                        print("TRUE")
                    } else {
                        print("FALSE")
                    }
                }
                
                DispatchQueue.main.async {
                
                    let alert = UIAlertController(title: "Hello CS207 Class", message: "Reminder that your final project teams will be assigned next week", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                }
                
            } catch {
                print("JSONDecoder error : \(error)")
            }
            //print("JSONData = \(jsonData)")
        }
        
        task.resume()
        
        
        
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
