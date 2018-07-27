//
//  DatabaseModelNormal.swift
//  EMA
//
//  Created by Ertugrul Yilmaz on 27.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseModelNormalWorkingRoutine: Object {
    @objc dynamic var date = Date()
    @objc dynamic var field = ""
    @objc dynamic var username = ""
    @objc dynamic var workingHour = 0
}
