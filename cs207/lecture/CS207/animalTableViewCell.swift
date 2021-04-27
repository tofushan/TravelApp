//
//  animalTableViewCell.swift
//  CS207
//
//  Created by Hugh Thomas on 2/10/21.
//

import UIKit

class animalTableViewCell: UITableViewCell {

    @IBOutlet weak var animalImage: UIImageView!
    
    @IBOutlet weak var animalName: UILabel!
    
    @IBOutlet weak var animalPropensity: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
