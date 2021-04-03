//
//  CountriesTableVCTableViewController.swift
//  the-best-world-traveler
//
//  Created by 劉軒甫 on 4/3/21.
//

import UIKit

class CountriesTableVCTableViewController: UITableViewController {
    
    // struct of json for countries data
    struct country: Codable {
        let continentCode, isoA3, currency, value: String
        let currencyCode, key, currencyNumCode: String

        enum CodingKeys: String, CodingKey {
            case continentCode = "continent_code"
            case isoA3 = "iso_a3"
            case currency, value
            case currencyCode = "currency_code"
            case key
            case currencyNumCode = "currency_num_code"
        }
    }
    
    // array in which data are parsed
    var countries : [ country ] = [ ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    func getCountriesFromAPI() {
        
        // configuration of countries API
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "x-rapidapi-key": "d18d7c0b4dmsh0d1fbc5ff1355c3p1593cbjsn9215a5fbccdb",
                "x-rapidapi-host": "referential.p.rapidapi.com"
            ]
        config.timeoutIntervalForRequest = 30
        
        let mySession = URLSession(configuration: config)
        let url = URL(string: "https://referential.p.rapidapi.com/v1/country?fields=currency%2Ccurrency_num_code%2Ccurrency_code%2Ccontinent_code%2Ccurrency%2Ciso_a3%2Cdial_code")!
        
        let task = mySession.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print( "ERROR: \(error!)" )
                
                // pop up window showing the error
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Fail to pull data from API ", message: "\(error!)", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                }
                return
            }
            
            // ensure the data is successfully pulled from API
            guard let jsonData = data else {
                print("No data ...")
                return
            }
            
            do {
                // load json items into array
                self.countries = try JSONDecoder().decode( [ country ].self, from: jsonData )
                // reload the data that is used to construct the table, including cells, section headers, index arrays and footers ... etc.
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            
            }catch {
                print( "ERROR: Pokemon information cannot be decoded." )
                print( "\(error)" )
            }
        }
        task.resume()
        print("Data is loaded successfully.")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
