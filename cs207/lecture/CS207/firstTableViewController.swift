//
//  firstTableViewController.swift
//  CS207
//
//  Created by Hugh Thomas on 2/5/21.
//

import UIKit

class firstTableViewController: UITableViewController {

    var animals: [String] = ["Cat", "Dog", "Horse"]
    var animalDescriptions: [String] = ["Mostly Friendly", "Friendly", "Always Friendly"]
    var animalPictures: [UIImage] = [UIImage(named:"cat")!, UIImage(named: "dog")!, UIImage(named: "horse")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return animals.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myBasicCell", for: indexPath) as! animalTableViewCell

        // Configure the cell...
        cell.animalName.text = animals[indexPath.row]
        cell.animalPropensity.text = animalDescriptions[indexPath.row]
        cell.animalImage.image = animalPictures[indexPath.row]
        
        //cell.backgroundColor = .red

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return("My Favorite Animals")
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
        
        let destVC = segue.destination as! animalDetailViewController
        
        let selectRow = tableView.indexPathForSelectedRow?.row
        
        destVC.name = animals[selectRow!]
        destVC.descrip = animalDescriptions[selectRow!]
        destVC.picture = animalPictures[selectRow!]
        
    }
    

}
