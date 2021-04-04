//
//  navSearchBarVC.swift
//  the-best-world-traveler
//
//  Created by Jaylyn Barbee on 3/30/21.
//

import UIKit

class navSearchBarVC: UINavigationController {

    private let searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.sizeToFit()
        self.navigationItem.titleView = searchBar
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
