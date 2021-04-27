//
//  photoCollectionViewController.swift
//  CS207
//
//  Created by Hugh Thomas on 3/29/21.
//

import UIKit

class photoCollectionViewController: UICollectionViewController {

    let animalPhotos: [UIImage] = [UIImage(named: "cat")!, UIImage(named: "dog")!, UIImage(named: "horse")!, UIImage(named: "cat")!, UIImage(named: "dog")!, UIImage(named: "horse")!, UIImage(named: "cat")!, UIImage(named: "dog")!, UIImage(named: "horse")!, UIImage(named: "horse")!]
    let animalNames: [String] = ["Cath","Ci","Ceffyl","Chat","Chien","Cheval","Cat","Dog","Horse","Caballo"]
    
                                   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animalPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? photoCollectionViewCell {
    
            customCell.photoImage.image = animalPhotos[indexPath.row]
            customCell.nameLabel.text = animalNames[indexPath.row]
             
            cell = customCell
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    */
    
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
