//
//  weather.swift
//  WeatherReport
//
//  Created by 劉軒甫 on 2/6/21.
//

import UIKit

class pokemonInfoTable: UITableViewController {
    
    var curr_pokemon: String = ""
    var curr_saturation: Float = 1.0
    
    // set up struct to decode the specific type of json objects
    struct pokemon: Decodable {
        let pokemon_id: Int
        let pokemon_name: String
        let min_pokemon_action_frequency: Float
        let max_pokemon_action_frequency: Float
        let form: String
        let dodge_probability: Float
        let base_flee_rate: Float
        let base_capture_rate: Float
        let attack_probability: Float
    }
    
    typealias pokeJson = [ pokemon ]
    
    // array in which the json info is parsed
    var pokeDict: [ pokemon ] = [ ]
    
    /*
    var city : [String] = ["Durham", "Chapel Hill", "Carrboro", "Morrisville", "Raleigh", "Cary" ]
    var temp : [String] = ["78", "78", "77", "80", "82", "81" ]
    var weather : [String] = [ "cloudy", "sunny", "sunny", "cloudy", "rain", "rain"]
    var weatherPic: [String: UIImage] = [ "cloudy": UIImage(named: "Cloudy")!,
                                          "sunny" : UIImage(named: "Sunny")!,
                                          "rain": UIImage(named: "Rainy")!]
    */
    func getData() {
    
        // if want to configure for specific type of HTTP
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "x-rapidapi-key": "d18d7c0b4dmsh0d1fbc5ff1355c3p1593cbjsn9215a5fbccdb",
                "x-rapidapi-host": "pokemon-go1.p.rapidapi.com"
            ]
        config.timeoutIntervalForRequest = 30
        
        let mySession = URLSession(configuration: config)
        // want to fetch Pokemon Go info data
        let url = URL( string: "https://pokemon-go1.p.rapidapi.com/pokemon_encounter_data.json" )!
        
        // this is the trailing closure
        let task = mySession.dataTask(with: url) { data, response, error in
            
            // ensure no errors from this HTTP response
            guard error == nil else {
                print( "ERROR: \(error!)" )
                
                // pop up window showing the error
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error - ", message: "\(error!)", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                }
                return
            }
            
            // ensure the data is returned from this HTTP response
            guard let jsonData = data else {
                print( "No data!" )
                return
            }
            
            //print("Json data = \(jsonData)")
            do {
                // load json items into array
                self.pokeDict = try JSONDecoder().decode( pokeJson.self, from: jsonData )
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View is loaded.")
        
        self.getData()

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
        // #warning Incomplete implementation, return the number of rows
        return pokeDict.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherCellTableViewCell
        /*
        cell.City.text = city[indexPath.row]
        cell.Weather.text = weather[indexPath.row]
        cell.Temp.text = temp[indexPath.row] + " °F"
        cell.myPic.image = weatherPic[weather[indexPath.row]]
        */
        
        // Configure the cell...
        // this function will be called multiple times, so no need to write a for loop
        //let key : String = Array(pokeDict.keys)[indexPath.row]
        cell.textLabel?.text = String( pokeDict[indexPath.row].pokemon_name )
        cell.detailTextLabel?.text = pokeDict[indexPath.row].form + " type"
        
        let h: CGFloat = CGFloat(pokeDict[indexPath.row].pokemon_id % 5)/5 + 0.2
        if curr_pokemon != pokeDict[indexPath.row].pokemon_name {
            curr_saturation = 1.0
            curr_pokemon = pokeDict[indexPath.row].pokemon_name
        }
        else {
            curr_saturation -= 0.2
        }
        
        cell.backgroundColor = UIColor(hue: h, saturation: CGFloat(curr_saturation),brightness: 0.5, alpha: 0.2)
        
        return cell
    }
    
    // header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return("Pokemon Encounter Data")
        
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
        let destVC = segue.destination as! DetailVC
        let selectRow = tableView.indexPathForSelectedRow?.row
        /*
        destVC.city_name = city[selectRow!]
        destVC.temp_degree = temp[selectRow!]
        destVC.weather_name = weather[selectRow!]
        destVC.pic = weatherPic[weather[selectRow!]]
        */
        destVC.pName = pokeDict[selectRow!].pokemon_name
        destVC.pForm = pokeDict[selectRow!].form
        destVC.pMinAct = pokeDict[selectRow!].min_pokemon_action_frequency
        destVC.pMaxAct = pokeDict[selectRow!].max_pokemon_action_frequency
        destVC.pDodge = pokeDict[selectRow!].dodge_probability
        destVC.pFlee = pokeDict[selectRow!].base_flee_rate
        destVC.pCapture = pokeDict[selectRow!].base_capture_rate
        destVC.pAttack = pokeDict[selectRow!].attack_probability
        
        
        //print(city[selectRow!])
    
    }
    
    

}
