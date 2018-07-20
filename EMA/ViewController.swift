//
//  ViewController.swift
//  EMA
//
//  Created by Mustafa Sahinli on 20.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBAction func login(_ sender: Any) {
        
        
        let benutzername = self.username.text
        let passwort = self.password.text
        let db_benutzername = "benutzername"
        let db_passwort = "passwort"
        if benutzername == db_benutzername && passwort == db_passwort
        {
          
            print("Test")
        }
        else  {
            print ("Fehlgeschlagen")
        }
        //Methode für das Überprüfen vom Passwort und dem Benutzernamen und Action Button für das Login
        
    }
    
            
        
        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

