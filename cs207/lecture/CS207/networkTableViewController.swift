//
//  networkTableViewController.swift
//  CS207
//
//  Created by Hugh Thomas on 2/19/21.
//

import UIKit

class networkTableViewController: UITableViewController {

    struct todoItem: Decodable {
        var userId:Int
        var id:Int
        var title:String
        var completed:Bool
    }
    
    var allTodos:[todoItem] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getAllData()
    }

    func getAllData() {
        
        // get the data from the internet
        let customConfig = URLSessionConfiguration.default
        customConfig.httpAdditionalHeaders = [
            "rapid-api-key": "akdsjhf;wkdshfgd;ksjqhdfk"
        ]
        
        let mySession = URLSession(configuration: customConfig) // URLSessionConfiguration.default)
        
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
                
                self.allTodos = try JSONDecoder().decode([todoItem].self, from: jsonData)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print("JSONDecoder error : \(error)")
            }
        
        }
        
        task.resume()
        
        print("Data is loaded")
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allTodos.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTodoCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = allTodos[indexPath.row].title
        cell.detailTextLabel?.text = String(allTodos[indexPath.row].id)
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
