//
//  addCountryViewController.swift
//  the-best-world-traveler
//
//  Created by Jaylyn Barbee on 4/4/21.
//

import UIKit

class addCountryViewController: UIViewController, UISearchBarDelegate {
    
    var country: String = ""


    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = backButton
        
        let saveButton: UIBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(add))
        self.navigationItem.rightBarButtonItem = saveButton
        
        self.navigationItem.title = country
        
        searchBar.delegate = self
        
    }

    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func add(){
        print("Will figure out save logic later")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let CVC = children.last as! addedCityTableViewController

        CVC.changeData(data: searchBar.text!)
        
        print("searchText \(searchBar.text ?? "")")
    }


    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cvc = segue.destination as! addedCityTableViewController
        
    }
    */
    
    

}
