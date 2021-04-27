//
//  WeatherCellTableViewCell.swift
//  WeatherReport
//
//  Created by 劉軒甫 on 2/13/21.
//

import UIKit

class WeatherCellTableViewCell: UITableViewCell {

    @IBOutlet weak var myPic: UIImageView!
    
    @IBOutlet weak var City: UILabel!
    
    @IBOutlet weak var Weather: UILabel!
    
    @IBOutlet weak var Temp: UILabel!
    //var pic : UIImage! = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
