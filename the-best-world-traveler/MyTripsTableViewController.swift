//
//  TableViewController.swift
//  the-best-world-traveler
//
//  Created by Hsuan Fu Liu on 4/13/21.
//

import UIKit
import Firebase
import FirebaseAuth


public struct counties: Codable {
    let date: String
    let city: String
    let note: String
}




class MyTripsTableViewController: UITableViewController {
    
    let db = Firestore.firestore()
    var countries_to_visit: [String:[String]] = [ : ]
    
    override func viewDidLoad() {
        
        self.fetchTripsFromUser()
        super.viewDidLoad()
    
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func fetchTripsFromUser() {
        // get user ID to store the data
        let userID : String = (Auth.auth().currentUser?.uid)!
        
        let userData = db.collection("users").document(userID)
        userData.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                
                // Look at here for retrieving the user data
                // let email: String = document.get("email") as! String
                // let nickname: String = document.get("nickname") as! String
                self.countries_to_visit = document.get("countries_to_visit") as? [String:[String]] ?? [:]
                self.tableView.reloadData()
            } else {
                print("Document does not exist")
            }
        }
    }
    

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Array(self.countries_to_visit.keys).count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTripsCell", for: indexPath)

        // Configure the cell...
        let countriesList: [String] = Array(self.countries_to_visit.keys)
        cell.textLabel?.text = countriesList[indexPath.row]
        cell.detailTextLabel?.text = countries_to_visit[countriesList[indexPath.row]]?[0]
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
