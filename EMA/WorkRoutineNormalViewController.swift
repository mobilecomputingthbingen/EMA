//
//  WorkRoutineNormalViewController.swift
//  EMA
//
//  Created by Ertugrul Yilmaz on 25.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit
import RealmSwift
/**
 Klasse für die Entlaubung.
 **Note :** Für weitere Informationen auf die Parameter klicken.*/
class WorkRoutineNormalViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    ///Variable für UIPicker Datum
    @IBOutlet weak var datePicker: UIDatePicker!
    ///Variable für UIPicker Feld
    @IBOutlet weak var fieldPicker: UIPickerView!
    ///Variable für UIPicker Arbeitsstunden
    @IBOutlet weak var workingHourPicker: UIPickerView!
    ///Variable Benutzername
    @IBOutlet weak var userNameLabel: UILabel!
    ///Variable Status
    var workState: WorkState!
    ///Variable Database Manager
    let databaseManager = DatabaseManager.shared
    ///Variable Datenbankitem
    var databaseModelNormal = DatabaseModelNormalWorkingRoutine()
    ///User Defaults
    let defaults = UserDefaults.standard
    ///Items der Arbeisstunden
    let workingHourItems = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    ///Definierung des Feldes
    var fieldItems = [Field]()
    ///Definierung Arbeitsstunden
    var workingHour = 1
    ///Definierung Feld
    var field = ""
    ///Funktion für das Holen von Objekten aus der DB.
    func getAllObjects() {
        let objects = databaseManager.getObjects(type: Field.self)
        for element in objects {
            if let field = element as? Field {
                fieldItems.append(field)
            }
        }
    }
    ///Funktion für das Laden der View.
    override func viewDidLoad() {
        super.viewDidLoad()

        fieldItems.removeAll()
        getAllObjects()

        fieldPicker.dataSource = self
        fieldPicker.delegate = self

        workingHourPicker.dataSource = self
        workingHourPicker.delegate = self

        let addWorkingRoutineButton = UIBarButtonItem(
            image: #imageLiteral(resourceName: "check"),
            style: .plain,
            target: self,
            action: #selector(addButton(sender:))
        )
        self.navigationItem.rightBarButtonItem = addWorkingRoutineButton

        userNameLabel.text = defaults.string(forKey: "CurrentUsername")!

        if workState == WorkState.edit {
            datePicker.date = databaseModelNormal.date
            var fieldPlace = 0
            var searchedFieldExists = false
            for counter in 0...fieldItems.count - 1 where databaseModelNormal.field == fieldItems[counter].name {
                fieldPlace = counter
                searchedFieldExists = true
            }
            if searchedFieldExists {
                fieldPicker.selectRow(fieldPlace, inComponent: 0, animated: true)
            }
            workingHourPicker.selectRow(databaseModelNormal.workingHour - 1, inComponent: 0, animated: true)
            field = databaseModelNormal.field
            workingHour = databaseModelNormal.workingHour
        }
        if workState == WorkState.add {
            if fieldItems.count > 0 {
                field = fieldItems[0].name
            }
            workingHour = Int(workingHourItems[0])!
        }
    }
    ///Funktion für den Button.
    @objc func addButton(sender: UIBarButtonItem) {
        let date = datePicker.date

        if workState == WorkState.add {
            if fieldItems.count > 0 {
                self.databaseModelNormal.date = date
                self.databaseModelNormal.username = defaults.string(forKey: "CurrentUsername")!
                self.databaseModelNormal.field = self.field
                self.databaseModelNormal.workingHour = self.workingHour
                self.databaseManager.addToDatabase(object: databaseModelNormal)
                self.navigationController?.popViewController(animated: true)
            } else {
                let alertController = UIAlertController(title: "Keine Felder", message:
                    "Erstelle Felder um Einträge zu erstellen", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
        if workState == WorkState.edit {
            let realm = try! Realm() // swiftlint:disable:this force_try
            try! realm.write { // swiftlint:disable:this force_try
                self.databaseModelNormal.date = date
                self.databaseModelNormal.username = self.defaults.string(forKey: "CurrentUsername")!
                self.databaseModelNormal.workingHour = self.workingHour
                self.databaseModelNormal.field = self.field
            }
            self.navigationController?.popViewController(animated: true)
        }
    }

    ///Funktion für den PickerView.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == fieldPicker {
            if fieldItems.count > 0 {
                field = fieldItems[row].name
            }
        } else if pickerView == workingHourPicker {
            workingHour = Int(workingHourItems[row])!
        }
    }
    /// Anzahl der Komponenten
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    ///Anzahl der Zeilen
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == fieldPicker {
            return fieldItems.count
        } else if pickerView == workingHourPicker {
            return workingHourItems.count
        } else {
            return 0
        }
    }
    ///Titel der Zeilen
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == fieldPicker {
            return fieldItems[row].name
        } else if pickerView == workingHourPicker {
            return workingHourItems[row]
        } else {
            return "No Items defined"
        }
    }
}
