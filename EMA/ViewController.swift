//
//  ViewController.swift
//  EMA
//
//  Created by Mustafa Sahinli on 20.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//



/**
 Klasse für die Überprüfung des Logins , sowie Definierung von mehreren Parametern.
 
 - showHideButton: Definierung und Implementierung vom Anzeigen des Passwortes , je nach Klicken auf den Button.
 - errorcode: Je nach Richtigkeit des Passwortes, wird durch die Definierung dieser Variable die Farbe der Authentifizierung  auf rot oder grün gestellt.
 - passwort: Variable für das interne Speichern des Passwortes
 - username: Variable für das interne Speichern des Benutzernamens.
 ## Beispiel: ## ````
 Erscheinen der Farbe für die Authentifizierung (ROT) bei falschem Login.
 Erscheinen der Farbe für die Authentifizierung (Grün) bei richtigem Login.

 ````
 **Note :** Für weitere Informationen auf die Parameter klicken.*/
import UIKit
class ViewController: UIViewController {

    var isPasswordVisible = false

    @IBOutlet weak var showHideButton: UIButton! ///  - showHideButton: Definierung und Implementierung vom Anzeigen des Passwortes , je nach Klicken auf den Button.

    @IBOutlet weak var errorcode: UILabel! /// Je nach Richtigkeit des Passwortes, wird durch die Definierung dieser Variable die Farbe der Authentifizierung  auf rot oder grün gestellt.
    @IBOutlet weak var username: UITextField! /// Variable für das interne Speichern des Benutzernamens.
    
    @IBOutlet weak var password: UITextField! /// Variable für das interne Speichern des Passwortes.
    override func viewDidLoad() { /// Funktion für das Laden der View.
        super.viewDidLoad()
        showHideButton.setImage(#imageLiteral(resourceName: "hide"), for: .normal)
    }

    @IBAction func login(_ sender: Any) {

        let loginManager = LoginManager()

        let isLoginSuccessful = loginManager.tryLogin(username: self.username.text!, password: self.password.text!)

        if isLoginSuccessful {
            let defaults = UserDefaults.standard
            defaults.set(username.text, forKey: "CurrentUsername")
            self.errorcode.textColor = UIColor.green
            self.errorcode.text = "Authentifizierung erfolgreich"
            fadeViewIn(view: errorcode, isLoginSuccessful: true)
        } else {
            self.errorcode.textColor = UIColor.red
            self.errorcode.text = "Authentifizierung fehlgeschlagen"
            fadeViewIn(view: errorcode, isLoginSuccessful: false)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func fadeViewIn(view: UIView, isLoginSuccessful: Bool) {
        let animationDuration = 1.0
        view.alpha = 0
        UIView.animate(withDuration: animationDuration, animations: {
            view.alpha = 1
        }, completion: { (finished: Bool) in
            if finished && isLoginSuccessful {
                self.changeViewToMenu()
            }
        })
    }

    func changeViewToMenu() {
        performSegue(withIdentifier: "segueFromLoginToMenu", sender: self)
    }

    @IBAction func showHideButtonTouchUpInsideHandler(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        if isPasswordVisible {
            password.isSecureTextEntry = false
            showHideButton.setImage(#imageLiteral(resourceName: "show"), for: .normal)
        } else {
            password.isSecureTextEntry = true
            showHideButton.setImage(#imageLiteral(resourceName: "hide"), for: .normal)
        }
        let currentText: String = password.text!
        password.text = ""
        password.text = currentText
    }
}
