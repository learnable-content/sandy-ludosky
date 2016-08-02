//
//  ViewController.swift
//  ContactsList
//
//  Created by Sandy L on 2016-05-16.
//  Copyright © 2016 Sandy L. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*document ref = https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSUserDefaults_Class/index.html
        */
     
       //setObjet() allows to save a default value tot the default system of the application
       NSUserDefaults.standardUserDefaults().setObject("Sandy", forKey: "username")
       NSUserDefaults.standardUserDefaults().setObject("dd/mm/yyyy", forKey: "dob")
        
        //with objectForKey(), you can retrieve a default value by targetting a specific key
        //In the following examples, you return the values for the keys 'username' and 'dob'
        let username = NSUserDefaults.standardUserDefaults().objectForKey("username")
        let dob = NSUserDefaults.standardUserDefaults().objectForKey( "dob")
        
        print(username!)
        print(dob!)
        
        
        //contacts list
        let contacts = [
            
            ["username": "Sandy",
             "age": "25",
            "dob": "dd/mm/yyyy"],
            
            ["username": "Judy",
                "age": "23",
                "dob": "dd/mm/yyyy"],
            
            ["username": "Lawry",
                "age": "20",
                "dob": "dd/mm/yyyy"]
        
        ]
        
        
        NSUserDefaults.standardUserDefaults().setObject(contacts, forKey: "contactsList")
        
        
        let contactsList = NSUserDefaults.standardUserDefaults().objectForKey("contactsList") as! NSArray
        
        
        
        for user in contactsList {
            
            print(user["username"] as! String)
            print(user["age"] as! String)
            print(user["dob"] as! String)
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

