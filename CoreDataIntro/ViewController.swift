//
//  ViewController.swift
//  CoreDataIntro
//
//  Created by Sandy L on 2016-05-23.
//  Copyright © 2016 Sandy. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //manageObjectContext
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        //new record
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context)
        
        newUser.setValue("Sandy", forKey: "name")
        newUser.setValue(25, forKey: "age")
        
        
        //saving Core Data
        do {
            try context.save()
            print("record successfully saved to core data")
        } catch {
            
            print("error saving to the core data")
        
        }
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

