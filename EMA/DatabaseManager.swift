//
//  DatabaseManager.swift
//  EMA
//
//  Created by Ertugrul Yilmaz on 23.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import Foundation
import RealmSwift
/**
 Klasse für das Managen der Datenbank.
 **Note :** Für weitere Informationen auf die Parameter klicken.*/
class DatabaseManager {
    ///Datenbankvariable
    private var database: Realm
    ///Statische Datenbankvariable
    static let shared = DatabaseManager()
    ///Initalisierung der Datenbank.
    init() {
        database = try! Realm()
    }
    ///Funktion für das Holen der Objekte aus der Datenbank .
    func getObjects(type: Object.Type) -> Results<Object> {
        return database.objects(type)
    }
    ///Funktion für das Holen der Objekte aus der Datenbank mit Filter.
    func getObjects(type: Object.Type, with filter: String) -> Results<Object> {
        return database.objects(type).filter(filter)
    }
    ///Funktion für das Hinzufügen von Objekten in die DB.
    func addToDatabase(object: Object) {
        do {
            try database.write {
                database.add(object)
            }
        } catch {
            print("Could not write to database")
        }

    }
    ///Funktion für das Entfernen von Objekten aus der DB.
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
