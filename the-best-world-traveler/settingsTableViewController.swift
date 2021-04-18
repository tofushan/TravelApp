//
//  settingsTableViewController.swift
//  the-best-world-traveler
//
//  Created by Avery Brown II on 4/6/21.
//

import UIKit
import Firebase
import FirebaseAuth

class settingsTableViewController: UITableViewController {

    var settings: [String] = ["My Account", "Trips Planned", "Trips Completed", "Security & Privacy", "Help", "About Us", "Log out"]
    
    
    
    override func viewDidLoad() {
        
        //self.hideKeyboardWhenTappedAround()
        tableView?.allowsSelection = true

        super.viewDidLoad()

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
        return settings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! settingsCustomTableViewCell

        // Configure the cell...
        cell.settingTitle?.text = settings[indexPath.row]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "myAccountView", sender: self)
        }
        else if indexPath.row == 1 {
            self.performSegue(withIdentifier: "myTripsView", sender: self)
        }
        else if indexPath.row == 2 {
            self.performSegue(withIdentifier: "myTripsView", sender: self)
        }
        else if indexPath.row == 3 {
            self.performSegue(withIdentifier: "securityAndPrivacyView", sender: self)
        }
        else if indexPath.row == 4 {
            self.performSegue(withIdentifier: "helpView", sender: self)
        }
        else if indexPath.row == 5 {
            self.performSegue(withIdentifier: "aboutView", sender: self)
        }
        else if indexPath.row == 6 {
            do {
                // sign out and go back to root page (login page)
                try Auth.auth().signOut()
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            }
            catch {
                print("Cannot logout!")
            }
        }
    }
    
    
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "myAccountNav") as UIViewController
            self.present(viewController, animated: false, completion: nil)
        }
    }
 */
       
    

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

     //MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
        let selectedRowIndex = self.tableView.indexPathForSelectedRow![1]
        if 1 ... 2 ~= selectedRowIndex {
            let destVC = segue.destination as! MyTripsTableViewController
            destVC.row = selectedRowIndex
        }
    
    }
}

/*
extension settingsTableViewController{
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(settingsTableViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
 */
