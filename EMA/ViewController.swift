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
    @IBOutlet weak var errorcode: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func login(_ sender: Any) {
        let loginUsername = self.username.text
        let loginPassword = self.password.text
        let databaseUsername = "benutzername"
        let databasePassword = "passwort"
        if loginUsername == databaseUsername && loginPassword == databasePassword {
            print("Erfolgreich")
            self.errorcode.text = ""
        } else {
            print ("Fehlgeschlagen")
            self.errorcode.text = "Authentifizierung fehlgeschlagen"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
