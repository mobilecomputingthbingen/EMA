//
//  FieldsViewController.swift
//  EMA
//
//  Created by Veli Tasyurdu on 22.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit
import RealmSwift

class FieldsViewController: UITableViewController {
    var fields: Results<Object>?
    let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        fields = DatabaseManager.shared.getObjects(type: Field.self)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = fields?.count else { return 0}
        return items
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        guard let field = fields![indexPath.item] as? Field else { return UITableViewCell()}
        cell.textLabel?.text = "Feld: \(field.name) (\(String(format: "%.0f m^2)", field.size))"
        cell.detailTextLabel?.text = "Reben Sorte: \(field.sort)"
        return cell
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Bearbeit.") { (action, index) in
            if let field = self.fields?[indexPath.item] {
                if let field = field as? Field {
                    let alertController = UIAlertController(title: "Feld bearbeiten", message: nil, preferredStyle: .alert)
                    alertController.addTextField { (textField) in
                        textField.text = field.name
                    }
                    alertController.addTextField { (textField) in
                        textField.text = field.sort
                    }
                    let saveAction = UIAlertAction(title: "Speichern", style: .default) { (alert) in
                        let nameTextField = alertController.textFields![0] as UITextField
                        let sortTextField = alertController.textFields![1] as UITextField
                        self.saveToDB(name: nameTextField.text!, sort: sortTextField.text!)
                    }
                    let cancelAction = UIAlertAction(title: "Abbrechen", style: .cancel, handler: nil)
                    alertController.addAction(saveAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }

        }
        edit.backgroundColor = UIColor.blue
        let delete = UITableViewRowAction(style: .destructive, title: "Löschen") { (action, index) in
            print("Delete tapped")
        }
        return [delete, edit]
    }
    @objc private func saveToDB(name: String, sort: String) {
        if !name.isEmpty || !sort.isEmpty {
    
        } else {
            alert(message: "Feldname oder Reben Sorte darf nicht leer sein")
        }
    }
    @objc private func deleteFromDB(at index: Int) {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Felder"
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
    }
    private func alert(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Schließen", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
