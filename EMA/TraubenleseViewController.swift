//
//  TraubenleseViewController.swift
//  EMA
//
//  Created by Mustafa Sahinli on 31.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//
import UIKit
import RealmSwift
/**
 Klasse für das Traubenlese
 **Note :** Für weitere Informationen auf die Parameter klicken.*/
class TraubenleseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    ///Variable für den UIPicker Datum
    @IBOutlet weak var datePicker: UIDatePicker!
    ///Variable für den UIPicker Feld
    @IBOutlet weak var fieldPicker: UIPickerView!
    ///Variable für den UIPicker Arbeitsstunden
    @IBOutlet weak var workingHourPicker: UIPickerView!
    ///Variable für das Label Username
    @IBOutlet weak var userNameLabel: UILabel!
    ///Variable für den UIPicker Durchführung
    @IBOutlet weak var executionpicker: UIPickerView!
    ///Variable Status Veränderung
    var workState: WorkState!
    ///Variable Datenbankmanager
    let databaseManager = DatabaseManager.shared
    ///Datenbankitem
    var databaseModelNormal = DataBaseTraubenlese()
    ///Userdefaults
    let defaults = UserDefaults.standard
    ///Items Arbeitsstunden
    let workingHourItems = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    ///Items Durchführung
    let executionItems = ["Händisch", "Mechanisch"]
    ///Definierung Felder
    var fieldItems = [Field]()
    ///Definierung Arbeitsstunden
    var workingHour = 1
    ///Definierung Durchführung
    var execution = 1
    ///Definierung Feld
    var field = ""
    ///Holen der Objekte aus Db.
    func getAllObjects() {
        let objects = databaseManager.getObjects(type: Field.self)
        for element in objects {
            if let field = element as? Field {
                fieldItems.append(field)
            }
        }
    }
    ///Laden der View
    override func viewDidLoad() {
        super.viewDidLoad()
        fieldItems.removeAll()
        getAllObjects()
        fieldPicker.dataSource = self
        fieldPicker.delegate = self
        executionpicker.dataSource = self
        executionpicker.delegate = self
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
            executionpicker.selectRow(databaseModelNormal.execution - 1, inComponent: 0, animated: true)
            execution = databaseModelNormal.execution
        }
        if workState == WorkState.add {
            if fieldItems.count > 0 {
                field = fieldItems[0].name
            }
            workingHour = Int(workingHourItems[0])!
           // execution = Int(executionItems[0])!
        }
    }
    ///Funktion für den Button
    @objc func addButton(sender: UIBarButtonItem) {
        let date = datePicker.date
        if workState == WorkState.add {
            if fieldItems.count > 0 {
                self.databaseModelNormal.date = date
                self.databaseModelNormal.username = defaults.string(forKey: "CurrentUsername")!
                self.databaseModelNormal.field = self.field
                self.databaseModelNormal.workingHour = self.workingHour
                self.databaseModelNormal.execution = self.execution
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
                self.databaseModelNormal.execution = self.execution
                self.databaseModelNormal.field = self.field
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    ///Selektieren der Zeile
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == fieldPicker {
            if fieldItems.count > 0 {
                field = fieldItems[row].name
            }
        } else if pickerView == workingHourPicker {
            workingHour = Int(workingHourItems[row])!
        } else if pickerView == executionpicker {
            execution = Int(workingHourItems[row])!
        }
    }///Anzahl der Komponente
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    ///Anzahl der Zeilen
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == fieldPicker {
            return fieldItems.count
        } else if pickerView == workingHourPicker {
            return workingHourItems.count
        } else if pickerView == executionpicker {
            return executionItems.count
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
        } else if pickerView == executionpicker {
            return executionItems[row]
        } else {
            return "No Items defined"
        }
    }
}
