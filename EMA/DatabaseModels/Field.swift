//
//  Fields.swift
//  EMA
//
//  Created by Ertugrul Yilmaz on 27.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import Foundation
import RealmSwift
/**
 Klasse für die Datenbank des Feldes.
 **Note :** Für weitere Informationen auf die Parameter klicken.*/
class Field: Object {
    /// Variable für den Namen des Feldes
    @objc dynamic var name = ""
    /// Variable für die Sorte des Weines
    @objc dynamic var sort = ""
    /// Variable für die Flächengröße
    @objc dynamic var size = 0.0
    /// Variable für die Position
    let position = List<Location>() // Some chanes
}

/**
 Klasse für die Location.
 **Note :** Für weitere Informationen auf die Parameter klicken.*/
class Location: Object {
    /// Variable für die Latitude
    @objc dynamic var latitude = 0.0
    /// Variable für die Longitude
    @objc dynamic var longitude = 0.0
}
