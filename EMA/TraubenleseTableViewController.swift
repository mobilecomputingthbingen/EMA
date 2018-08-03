//
//  TraubenleseTableViewController.swift
//  EMA
//
//  Created by Mustafa Sahinli on 31.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit
import RealmSwift
/**
 Klasse für das Traubenlese.
 **Note :** Für weitere Informationen auf die Parameter klicken.*/
class TraubenleseTableViewController: UITableViewController {
    ///Variable für die ITEMS in der DB.
    var items = [DataBaseTraubenlese]()
    ///Variable für Datenbankmanager
    let databaseManager = DatabaseManager.shared
    ///Funktion für das Laden der View.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        items.removeAll()
        getAllObjects()
        tableView.reloadData()
    }
     ///Funktion für das Laden der Objekte aus der Datenbank.
    func getAllObjects() {
        let objects = databaseManager.getObjects(type: DataBaseTraubenlese.self)
        for element in objects {
            if let normal = element as? DataBaseTraubenlese {
                items.append(normal)
            }
        }
    }
    ///Funktion für das Laden der View.
    override func viewDidLoad() {
        super.viewDidLoad()
        let addWorkingRoutineButton = UIBarButtonItem(
            image: #imageLiteral(resourceName: "add"),
            style: .plain,
            target: self,
            action: #selector(addButton(sender:))
        )
        self.navigationItem.rightBarButtonItem = addWorkingRoutineButton
    }
    ///Funktion für den Button.
    @objc func addButton(sender: UIBarButtonItem) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let traubenleseViewController = mainStoryboard.instantiateViewController(
            withIdentifier: "Traubenlese") as? TraubenleseViewController
        traubenleseViewController?.title = "Hinzufügen"
        traubenleseViewController?.workState = WorkState.add
        traubenleseViewController?.navigationItem.backBarButtonItem?.title = "Zurück"
        self.navigationController?.pushViewController(traubenleseViewController!, animated: true)
    }
    ///Anzahl der Sektionen
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    ///Anzahl der Zeilen der TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
     ///Darstellung der Zellen.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TraubenleseCell", for: indexPath)
            as! TraubenleseCell // swiftlint:disable:this force_cast
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "de_DE")
        cell.dateLabel.text = dateFormatter.string(from: items[indexPath.item].date)
        cell.fieldLabel.text = items[indexPath.item].field
        cell.usernameLabel.text = items[indexPath.item].username
        return cell
    }
   ///Zelle kann editiert werden.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    ///Funktion für das Löschen der Zelle.
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            databaseManager.deleteFromDatabase(object: items[indexPath.row])
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    ///Funktion für das Selektieren der Zelle
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let traubenleseViewController = mainStoryboard.instantiateViewController(
            withIdentifier: "Traubenlese") as? TraubenleseViewController
        traubenleseViewController?.title = "Bearbeiten"
        traubenleseViewController?.workState = WorkState.edit
        traubenleseViewController?.databaseModelNormal = items[indexPath.item]
        self.navigationController?.pushViewController(traubenleseViewController!, animated: true)
    }
}
