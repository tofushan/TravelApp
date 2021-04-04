//
//  navSearchBar.swift
//  the-best-world-traveler
//
//  Created by Jaylyn Barbee on 3/30/21.
//

import UIKit

class navSearchBar: UINavigationBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self.viewModel
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search artists"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }

}
