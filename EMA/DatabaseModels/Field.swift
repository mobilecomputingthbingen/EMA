//
//  Fields.swift
//  EMA
//
//  Created by Ertugrul Yilmaz on 27.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import Foundation
import RealmSwift

class Field: Object {
    @objc dynamic var name = ""
    @objc dynamic var sort = ""
    @objc dynamic var size = 0.0
    let position = List<Location>()
}

class Location: Object {
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
}
