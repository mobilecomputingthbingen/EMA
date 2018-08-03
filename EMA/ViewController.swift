//
//  ViewController.swift
//  EMA
//
//  Created by Mustafa Sahinli on 20.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
import UIKit
/**
 Klasse für die Anzeige des Logings.
 
 - showHideButton: Definierung und Implementierung vom Anzeigen des Passwortes , je nach Klicken auf den Button.
 - errorcode: Durch die Definierung dieser Variable die Farbe der Authentifizierung  auf rot oder grün gestellt.
 - passwort: Variable für das interne Speichern des Passwortes
 - username: Variable für das interne Speichern des Benutzernamens.
 ## Beispiel: ## ````
 Erscheinen der Farbe für die Authentifizierung (ROT) bei falschem Login.
 Erscheinen der Farbe für die Authentifizierung (Grün) bei richtigem Login.
 
 ````
 **Note :** Für weitere Informationen auf die Parameter klicken.*/
class ViewController: UIViewController {
    ///Boolean Variable für die Anzeige des Passwortes.
    var isPasswordVisible = false
    ///Definierung und Implementierung vom Anzeigen des Passwortes.
    @IBOutlet weak var showHideButton: UIButton!
    ///Durch die Definierung wird die Farbe der Auth. auf eine Farbe gestellt.
    @IBOutlet weak var errorcode: UILabel!
    /// Variable für das interne Speichern des Benutzernamens.
    @IBOutlet weak var username: UITextField!
    /// Variable für das interne Speichern des Passwortes.
    @IBOutlet weak var password: UITextField!
    /// Funktion für das Laden der View.
    override func viewDidLoad() {
        super.viewDidLoad()
        showHideButton.setImage(#imageLiteral(resourceName: "hide"), for: .normal)
    }
    ///Funktion für das Login
    @IBAction func login(_ sender: Any) {
        ///Variable für den LoginManager
        let loginManager = LoginManager()
        ///Variable für den erfolgreichen Login
        let isLoginSuccessful = loginManager.tryLogin(username: self.username.text!, password: self.password.text!)
        ///Definierung je nach Einloggen. Erfolgreich oder Unerfolgreich.
        if isLoginSuccessful { //
            let defaults = UserDefaults.standard
            defaults.set(username.text, forKey: "CurrentUsername") //
            self.errorcode.textColor = UIColor.green
            self.errorcode.text = "Authentifizierung erfolgreich"
            fadeViewIn(view: errorcode, isLoginSuccessful: true)
        } else {
            self.errorcode.textColor = UIColor.red
            self.errorcode.text = "Authentifizierung fehlgeschlagen"
            fadeViewIn(view: errorcode, isLoginSuccessful: false)
        }
    }
/// Zuständige Methode für die Animation des Textfeldes.
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
///Wechselt die Ansicht zum Menü.
    func changeViewToMenu() {
        performSegue(withIdentifier: "segueFromLoginToMenu", sender: self)
    }
/// Methode zum Aktivieren des Sichtfeldes für das Passwort.
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
