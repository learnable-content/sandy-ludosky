//
//  ViewController.swift
//  SavingToCoreData
//
//  Created by Sandy L on 2016-05-23.
//  Copyright © 2016 Sandy. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var contactTableView: UITableView!
    var context:NSManagedObjectContext?
    var contacts = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        contactTableView.dataSource = self
        contactTableView.delegate = self
    
        
        //managedObjectContext
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        context = appDel.managedObjectContext
        
        
        //new contact
       //let newContact = NSEntityDescription.insertNewObjectForEntityForName("Contact", inManagedObjectContext: context!)
     
        //newContact.setValue("Annie", forKey: "username")
        //newContact.setValue("annie@gmail.com", forKey: "email")
       // newContact.setValue(30, forKey: "age")
        
        //saving to Core Data
        do {
            try context!.save()
           // print("new contact \(newContact) successfully saved to the core data")
        } catch {
            print("error saving to the core data")
        }
        
        fetch { (array, arrayData) -> () in
           
            self.contacts = array as! [NSDictionary]
            self.contactTableView.reloadData()
            
        }
    }
    
    
    
    func fetch(completion:(array:NSArray, arrayData:NSArray) -> ()) {
    
    
        let request = NSFetchRequest(entityName: "Contact")
        //request.predicate = NSPredicate(format: "username = %@", "Judy")
        var tempItems = [NSDictionary]()
        var tempData = [NSManagedObject]()
        
        do {
            
            let results = try context!.executeFetchRequest(request)
            
            for result in results as! [NSManagedObject] {
                
                result.setValue("judy@yahoo.com", forKey: "email")
                
            
                let username = result.valueForKey("username") as! String
                let email = result.valueForKey("email") as! String
                
                let newEntry = ["username": username, "email": email] 
                tempItems.append(newEntry)
                tempData.append(result)
                
            }
            
            //saving to Core Data
            do {
                try context!.save()
                // print("new contact \(newContact) successfully saved to the core data")
            } catch {
                print("error saving to the core data")
            }
            
           completion(array: tempItems, arrayData: tempData)
        
        
        } catch {
            
            print("error fetching results")
        }
    
    
    }
    
    
    func deleteContact(contact:String) {
    
    
        fetch { (array, arrayData) -> () in
            
            for result in arrayData {
                
               let contactName = result.valueForKey("username") as? String
                
                if contact == contactName! {
                
                    self.context?.deleteObject(result as! NSManagedObject)
                }
                
                //saving to Core Data
                do {
                    try self.context!.save()
                    print("contact deleted")
                } catch {
                    print("error deleting")
                }
             
            }
            
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
    
    //delegate TableView
   func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
   func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let contactUsername = contacts[indexPath.row]["username"] as? String
            
            deleteContact(contactUsername!)
            
            self.contacts.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            do {
                try context!.save()
            } catch {
                abort()
            }
        }
    }
    
    
}






























