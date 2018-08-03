//
//  DataBaseTraubenlese.swift
//  EMA
//
//  Created by Mustafa Sahinli on 03.08.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import Foundation
import RealmSwift
/**
 Klasse für die Datenbank der Funktion Traubenlese.

 **Note :** Für weitere Informationen auf die Parameter klicken.*/
class DataBaseTraubenlese: Object {
    ///Variable für das Datum
    @objc dynamic var date = Date()
    ///Variable für das gespeicherte Feld.
    @objc dynamic var field = ""
    /// Variable für den Benutzernamen
    @objc dynamic var username = ""
    /// Variable für die gearbeitete Stunden
    @objc dynamic var workingHour = 0
    /// Variable für die Durchführung
    @objc dynamic var execution = 0
}
