//
//  WeatherDetailVC.swift
//  WeatherReport
//
//  Created by 劉軒甫 on 2/13/21.
//

import UIKit

class WeatherDetailVC: UIViewController {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    
    @IBOutlet weak var weatherName: UILabel!
    @IBOutlet weak var Temp: UILabel!
    
    // initailize these var to fetch info from table view
    var city_name: String = ""
    var weather_name: String = ""
    var temp_degree: String = ""
    var pic: UIImage! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityName.text = city_name
        weatherImg.image = pic
        weatherName.text = weather_name
        Temp.text = temp_degree + " °F"

        // Do any additional setup after loading the view.
    }
    
    

    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
    */

}
