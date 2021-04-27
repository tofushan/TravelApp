//
//  ViewController.swift
//  coreDataDemo
//
//  Created by Hugh Thomas on 3/5/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //1. Get the context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //2. Create a new Entity object & set some data values
        let entity = NSEntityDescription.entity(forEntityName: "Names", in: context)
        let newName = NSManagedObject(entity: entity!, insertInto: context)
        newName.setValue("Hugh Smith", forKey: "names")
        newName.setValue(41, forKey: "age")
       
        //3. save the data
        do {
           try context.save() // Data Saved to persistent storage
          } catch {
           print("Error - CoreData failed saving")
        }
    
        //
        // Read the data from the database
        //
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Names")
        //request.predicate = NSPredicate(format: "age > %d", 21)

        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "names") as! String)
                print(data.value(forKey: "age") as! Decimal)
          }
        } catch {
            print("Error - CoreData failed reading")
        }
    }
    



}

