//
//  DatabaseModelNormal.swift
//  EMA
//
//  Created by Ertugrul Yilmaz on 27.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import Foundation
import RealmSwift
/**
Klasse für die Datenbank der Funktion Entlauben.
**Note :** Für weitere Informationen auf die Parameter klicken.*/
class DatabaseModelNormalWorkingRoutine: Object {
      ///Variable für das Datum
    @objc dynamic var date = Date()
    ///Variable für das gespeicherte Feld.
    @objc dynamic var field = ""
    /// Variable für den Benutzernamen
    @objc dynamic var username = ""
    /// Variable für die gearbeitete Stunden
    @objc dynamic var workingHour = 0
}
