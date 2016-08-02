//
//  ViewController.swift
//  SavingToCoreData
//
//  Created by Sandy L on 2016-05-23.
//  Copyright © 2016 Sandy. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var contactTableView: UITableView!
    var context:NSManagedObjectContext?
    var contacts = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        contactTableView.dataSource = self
    
        
        //managedObjectContext
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        context = appDel.managedObjectContext
        
        
        //new contact
        let newContact = NSEntityDescription.insertNewObjectForEntityForName("Contact", inManagedObjectContext: context!)
        
        newContact.setValue("Annie", forKey: "username")
        newContact.setValue("annie@gmail.com", forKey: "email")
        newContact.setValue(30, forKey: "age")
        
        //saving to Core Data
        do {
            try context!.save()
           // print("new contact \(newContact) successfully saved to the core data")
        } catch {
            print("error saving to the core data")
        }
        
        fetch { (array) -> () in
           
            self.contacts = array as! [NSDictionary]
            self.contactTableView.reloadData()
            
        }
    }
    
    
    
    func fetch(completion:(array:NSArray) -> ()) {
    
    
        let request = NSFetchRequest(entityName: "Contact")
        var tempItems = [NSDictionary]()
        
        do {
            
            let results = try context!.executeFetchRequest(request)
            
            for result in results as! [NSManagedObject] {
            
                let username = result.valueForKey("username") as! String
                let email = result.valueForKey("email") as! String
                
                let newEntry = ["username": username, "email": email] as! NSDictionary
                tempItems.append(newEntry)
                
            }
            
           completion(array: tempItems)
            
            
        
        } catch {
            
            print("error fetching results")
        }
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //data source TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel!.text = contacts[indexPath.row]["username"] as? String
        cell.detailTextLabel!.text = contacts[indexPath.row]["email"] as? String
        
        return cell
        
    }
    
    
    
}

