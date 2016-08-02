//
//  ViewController.swift
//  SavingToCoreData
//
//  Created by Sandy L on 2016-05-23.
//  Copyright © 2016 Sandy. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //managedObjectContext
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        
        //new contact
        let newContact = NSEntityDescription.insertNewObjectForEntityForName("Contact", inManagedObjectContext: context)
        
        newContact.setValue("Sandy", forKey: "username")
        newContact.setValue("sandy@gmail.com", forKey: "email")
        newContact.setValue(25, forKey: "age")
        
        //saving to Core Data
        do {
            try context.save()
            print("new contact \(newContact) successfully saved to the core data")
        } catch {
            print("error saving to the core data")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

