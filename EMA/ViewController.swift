//
//  ViewController.swift
//  EMA
//
//  Created by Mustafa Sahinli on 20.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var isPasswordVisible = false

    @IBOutlet weak var showHideButton: UIButton!
    @IBOutlet weak var errorcode: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        showHideButton.setImage(#imageLiteral(resourceName: "hide"), for: .normal)
    }

    @IBAction func login(_ sender: Any) {

        let loginManager = LoginManager()

        let isLoginSuccessful = loginManager.tryLogin(username: self.username.text!, password: self.password.text!)

        if isLoginSuccessful {
            self.errorcode.text = ""
        } else {
            fadeViewIn(view: errorcode)
            self.errorcode.text = "Authentifizierung fehlgeschlagen"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func fadeViewIn(view: UIView) {
        let animationDuration = 0.75
        view.alpha = 0
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            view.alpha = 1
        })
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
