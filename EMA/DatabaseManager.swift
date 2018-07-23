//
//  DatabaseManager.swift
//  EMA
//
//  Created by Ertugrul Yilmaz on 23.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager {

    private var database: Realm

    static let shared = DatabaseManager()

    init() {
        database = try! Realm()
    }

    func getObjects(type: Object.Type) -> Results<Object> {
        return database.objects(type)
    }

    func getObjects(type: Object.Type, with filter: String) -> Results<Object> {
        return database.objects(type).filter(filter)
    }

    func addToDatabase(object: Object) {
        do {
            try database.write {
                database.add(object)
            }
        } catch {
            print("Could not write to database")
        }

    }

    func deleteFromDatabase(object: Object) {
        do {
            try database.write {
                database.delete(object)
            }
        } catch {
            print("Could not delete from database")
        }
    }
}
