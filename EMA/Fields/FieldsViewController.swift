//
//  FieldsViewController.swift
//  EMA
//
//  Created by Veli Tasyurdu on 22.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//
import UIKit
import RealmSwift
/**
 Klasse für das Bearbeiten,Löschen von Feldern.
 **Note :** Für weitere Informationen auf die Parameter klicken.*/
class FieldsViewController: UITableViewController {
    ///Variable für alle Felder in der DB.
    var fields: Results<Object>?
    ///Variable für Zellid
    let cellId = "fieldCell"
    ///Laden der View.
    override func viewDidLoad() {
        super.viewDidLoad()
        fields = DatabaseManager.shared.getObjects(type: Field.self)
    }
    ///Anzahl der Zeilen in einer Sektion
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = fields?.count else { return 0}
        return items
    }
    ///Darstellung der Zelle.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        guard let field = fields![indexPath.item] as? Field else { return UITableViewCell()}
        cell.textLabel?.text = "Feld: \(field.name) (\(String(format: "%.0f m^2)", field.size))"
        cell.detailTextLabel?.text = "Reben Sorte: \(field.sort)"
        return cell
    }
    ///Bearbeiten der Zelle.
    override func tableView(_ tableView: UITableView,
                            editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal,
                                        title: "Bearbeit.") { (_, index) in
            if let field = self.fields?[indexPath.item] {
                if let field = field as? Field {
                    let alertController = UIAlertController(title: "Feld bearbeiten",
                                                            message: nil,
                                                            preferredStyle: .alert)
                    alertController.addTextField { (textField) in
                        textField.text = field.name
                    }
                    alertController.addTextField { (textField) in
                        textField.text = field.sort
                    }
                    let saveAction = UIAlertAction(title: "Speichern",
                                                   style: .default) { (_) in
                        let nameTextField = alertController.textFields![0] as UITextField
                        let sortTextField = alertController.textFields![1] as UITextField
                        self.saveToDB(name: nameTextField.text!, sort: sortTextField.text!, index: index.item)
                    }
                    let cancelAction = UIAlertAction(title: "Abbrechen", style: .cancel, handler: nil)
                    alertController.addAction(saveAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        edit.backgroundColor = UIColor.blue
        let delete = UITableViewRowAction(style: .destructive, title: "Löschen") { (_, index) in
            let alertController = UIAlertController(title: "Feld löschen?", message: nil, preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Abbrechen", style: .cancel, handler: nil)
            let deleteButton = UIAlertAction(title: "Löschen", style: .destructive, handler: { (_) in
                self.deleteFromDB(at: index.item)
            })
            alertController.addAction(cancelButton)
            alertController.addAction(deleteButton)
            self.present(alertController, animated: true, completion: nil)
        }
        return [delete, edit]
    }
    ///Speichern in die DB.
    @objc private func saveToDB(name: String, sort: String, index: Int) {
        if let field = fields?[index] {
            if let field = field as? Field {
                if !name.isEmpty || !sort.isEmpty {
                    let realm = try! Realm() // swiftlint:disable:this force_try
                    try! realm.write { // swiftlint:disable:this force_try
                        field.name = name
                        field.sort = sort
                    }
                    self.tableView.reloadData()
                } else {
                    alert(message: "Feldname oder Reben Sorte darf nicht leer sein")
                }
            }
        }

    }
    ///Löschen aus der DB.
    @objc private func deleteFromDB(at index: Int) {  /// -deleteFromDB
        if let field = fields?[index] {
            if let field = field as? Field {
                DatabaseManager.shared.deleteFromDatabase(object: field)
            }
        }
        self.tableView.reloadData()
    }
    ///Erscheinen des Views.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Felder"
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
        self.tableView.reloadData()
    }
    ///Anzeigen einer Nachricht.
    private func alert(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Schließen", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
