//
//  WorkRoutineFertilizationViewController.swift
//  EMA
//
//  Created by Ertugrul Yilmaz on 03.08.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit
import RealmSwift

class WorkRoutineFertilizationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var fieldPicker: UIPickerView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var workingHourPicker: UIPickerView!
    @IBOutlet weak var fertilizePicker: UIPickerView!
    @IBOutlet weak var mineralicButton: UIButton!
    @IBOutlet weak var organicButton: UIButton!
    @IBOutlet weak var amountText: UITextField!

    var workState: WorkState!

    let databaseManager = DatabaseManager.shared

    var databaseModelFertilization = DatabaseModelFertilization()

    let defaults = UserDefaults.standard

    var fieldItems = [Field]()
    let workingHourItems = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    var mineralicItems = ["Entec perfect", "Entec 26", "Mg-Kalke", "Kalksalpeter"]
    var organicItems = ["Terragon", "Trester", "Rinder (25% TS)", "Bio(abfall)kompost"]

    var workingHour = 1
    var field = ""
    var category = ""
    var fertilize = ""

    var fertilizeArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        fieldItems.removeAll()
        getAllFields()

        fieldPicker.dataSource = self
        fieldPicker.delegate = self

        workingHourPicker.dataSource = self
        workingHourPicker.delegate = self

        fertilizePicker.dataSource = self
        fertilizePicker.delegate = self

        fertilizeArray = mineralicItems

        let addWorkingRoutineButton = UIBarButtonItem(
            image: #imageLiteral(resourceName: "check"),
            style: .plain,
            target: self,
            action: #selector(addButton(sender:))
        )
        self.navigationItem.rightBarButtonItem = addWorkingRoutineButton
        initializeView()
    }

    func initializeView() {
        userNameLabel.text = defaults.string(forKey: "CurrentUsername")!
        if workState == WorkState.edit {
            datePicker.date = databaseModelFertilization.date
            var fieldPlace = 0
            var searchedFieldExists = false
            for counter in 0...fieldItems.count - 1 where databaseModelFertilization.field == fieldItems[counter].name {
                fieldPlace = counter
                searchedFieldExists = true
            }
            if searchedFieldExists {
                fieldPicker.selectRow(fieldPlace, inComponent: 0, animated: true)
            }
            workingHourPicker.selectRow(databaseModelFertilization.workingHour - 1, inComponent: 0, animated: true)
            field = databaseModelFertilization.field
            workingHour = databaseModelFertilization.workingHour
            category = databaseModelFertilization.category
            fertilize = databaseModelFertilization.fertilize
            var fertilizePlace = 0
            var searchedFertilizeExists = false
            if category == "Mineralisch" {
                fertilizeArray = mineralicItems
                for counter in 0...mineralicItems.count - 1 where
                    databaseModelFertilization.fertilize == mineralicItems[counter] {
                        fertilizePlace = counter
                        searchedFertilizeExists = true
                }
            } else {
                fertilizeArray = organicItems
                for counter in 0...organicItems.count - 1 where
                    databaseModelFertilization.fertilize == organicItems[counter] {
                        fertilizePlace = counter
                        searchedFertilizeExists = true
                }
            }
            if searchedFertilizeExists {
                fertilizePicker.selectRow(fertilizePlace, inComponent: 0, animated: true)
            }
            if searchedFieldExists {
                fieldPicker.selectRow(fieldPlace, inComponent: 0, animated: true)
            }
            amountText.text = databaseModelFertilization.amount
        }
        if workState == WorkState.add {
            if fieldItems.count > 0 {
                field = fieldItems[0].name
            }
            workingHour = Int(workingHourItems[0])!
            category = "Mineralisch"
            fertilize = fertilizeArray[0]
        }
    }

    func getAllFields() {
        let objects = databaseManager.getObjects(type: Field.self)
        for element in objects {
            if let field = element as? Field {
                fieldItems.append(field)
            }
        }
    }

    @IBAction func mineralicButtonPressed(_ sender: UIButton) {
        category = "Mineralisch"
        fertilizeArray = mineralicItems
        fertilizePicker.reloadAllComponents()
        fertilizePicker.selectRow(0, inComponent: 0, animated: true)
    }

    @IBAction func organicButtonPressed(_ sender: UIButton) {
        category = "Organisch"
        fertilizeArray = organicItems
        fertilizePicker.reloadAllComponents()
        fertilizePicker.selectRow(0, inComponent: 0, animated: true)
    }
    @objc func addButton(sender: UIBarButtonItem) {
        let date = datePicker.date

        if workState == WorkState.add {
            if fieldItems.count > 0 {
                self.databaseModelFertilization.date = date
                self.databaseModelFertilization.username = defaults.string(forKey: "CurrentUsername")!
                self.databaseModelFertilization.field = self.field
                self.databaseModelFertilization.workingHour = self.workingHour
                self.databaseModelFertilization.category = self.category
                self.databaseModelFertilization.fertilize = self.fertilize
                self.databaseModelFertilization.amount = amountText.text!
                self.databaseManager.addToDatabase(object: databaseModelFertilization)
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
                self.databaseModelFertilization.date = date
                self.databaseModelFertilization.username = self.defaults.string(forKey: "CurrentUsername")!
                self.databaseModelFertilization.workingHour = self.workingHour
                self.databaseModelFertilization.field = self.field
                self.databaseModelFertilization.category = self.category
                self.databaseModelFertilization.fertilize = self.fertilize
                self.databaseModelFertilization.amount = amountText.text!
            }
            self.navigationController?.popViewController(animated: true)
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == fieldPicker {
            return fieldItems.count
        } else if pickerView == workingHourPicker {
            return workingHourItems.count
        } else if pickerView == fertilizePicker {
            return fertilizeArray.count
        } else {
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == fieldPicker {
            return fieldItems[row].name
        } else if pickerView == workingHourPicker {
            return workingHourItems[row]
        } else if pickerView == fertilizePicker {
            return fertilizeArray[row]
        } else {
            return "No Items defined"
        }
    }

    // sets the local variables
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == fieldPicker {
            if fieldItems.count > 0 {
                field = fieldItems[row].name
            }
        } else if pickerView == workingHourPicker {
            workingHour = Int(workingHourItems[row])!
        } else if pickerView == fertilizePicker {
            fertilize = fertilizeArray[row]
        }
    }
}
