//
//  WorkRoutineNormalViewController.swift
//  EMA
//
//  Created by Ertugrul Yilmaz on 25.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit
import RealmSwift

class WorkRoutineNormalViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var fieldPicker: UIPickerView!
    @IBOutlet weak var workingHourPicker: UIPickerView!
    @IBOutlet weak var userNameLabel: UILabel!

    var workState: WorkState!

    let databaseManager = DatabaseManager.shared

    var databaseModelNormal = DatabaseModelNormalWorkingRoutine()

    let defaults = UserDefaults.standard

    let workingHourItems = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    //var fieldItems = ["Bingen", "Schlossberg", "Gau-Algesheim"]
    var fieldItems = [Field]()

    var workingHour = 1
    var field = ""

    func getAllObjects() {
        let objects = databaseManager.getObjects(type: Field.self)
        for element in objects {
            if let field = element as? Field {
                fieldItems.append(field)
            }
        }
    }

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

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == fieldPicker {
            field = fieldItems[row].name //Fehler  
        } else if pickerView == workingHourPicker {
            workingHour = Int(workingHourItems[row])!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == fieldPicker {
            return fieldItems.count
        } else if pickerView == workingHourPicker {
            return workingHourItems.count
        } else {
            return 0
        }
    }

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
