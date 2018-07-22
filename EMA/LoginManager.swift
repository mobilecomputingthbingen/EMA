//
//  LoginManager.swift
//  EMA
//
//  Created by Ertugrul Yilmaz on 22.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import Foundation

class LoginManager {
    func tryLogin(username: String, password: String) -> Bool {
        let loginUsername = username
        let loginPassword = password
        let databaseUsername = "benutzername"
        let databasePassword = "passwort"
        if loginUsername == databaseUsername && loginPassword == databasePassword {
            return true
        } else {
            return false
        }
    }
}
