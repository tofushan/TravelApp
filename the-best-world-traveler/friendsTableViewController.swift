//
//  friendsTableViewController.swift
//  the-best-world-traveler
//
//  Created by Yilun Xie on 4/18/21.
//

import UIKit
import Firebase
import FirebaseAuth

class friendsTableViewController: UITableViewController, UISearchBarDelegate {

    var friends : [ String ] = [ ]

    var filteredData: [String] = []
    var friends_countries_to_visit : [[String:[String]]] = [[:]]
    var friends_countries_visited : [[String:[String]]] = [[:]]
    

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        // get all the user data from the database
        // and add their email to filteredData
        let collection = db.collection("users")
        collection.getDocuments() { (querySnapshot, err) in
            if let err = err {
                // print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    // print("\(document.documentID) => \(document.data())")
                    
                    self.friends.append( document.get("email") as? String ?? "" )
                    
                    self.friends_countries_to_visit.append( document.get("countries_to_visit") as? [String:[String]] ?? [:] )
                    self.friends_countries_visited.append( document.get("countries_already_visit") as? [String:[String]] ?? [:] )
                }
                print("DEBUG")
                print(self.friends)
            }
        }
        
        //filteredData = friends
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath)

        cell.textLabel?.text = String( filteredData[indexPath.row] )
        return cell
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//            // When there is no text, filteredData is the same as the original data
//            // When user has entered text into the search box
//            // Use the filter method to iterate over all items in the data array
//            // For each item, return true if the item should be included and false if the
//            // item should NOT be included
//            filteredData = []
//            filteredData = searchText.isEmpty ? filteredData : friends.filter { (item: String) -> Bool in
//                // If dataItem matches the searchText, return true to include it
//                return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//            }
//
//            tableView.reloadData()
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        filteredData = []
        filteredData = searchBar.text!.isEmpty ? filteredData : friends.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchBar.text!.lowercased(), options: .regularExpression, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // send the friend data picked by the user to the map view
        let selectRow = tableView.indexPathForSelectedRow?.row
        let select_email: String = filteredData[selectRow!]
        
        print("The selected email = " + String(select_email))
        
        let select_index: Int = friends.firstIndex(where: {$0 == select_email}) ?? 0
        
        let destViewController: friendsMapViewController = segue.destination as! friendsMapViewController
        //print(select_index)
        destViewController.trip = ["Canada", "United States"]
        destViewController.friend_email = self.friends[select_index]
        destViewController.countries_to_visit = self.friends_countries_to_visit[select_index]
        destViewController.countries_visited = self.friends_countries_visited[select_index]
        //print(self.friends_countries_to_visit[select_index])
    }
}
