//
//  DataBaseTraubenlese.swift
//  EMA
//
//  Created by Mustafa Sahinli on 03.08.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import Foundation
import RealmSwift

class DataBaseModelTraubenlese: Object {
    @objc dynamic var date = Date()
    @objc dynamic var field = ""
    @objc dynamic var username = ""
    @objc dynamic var workingHour = 0
    @objc dynamic var execution = 0 
}
