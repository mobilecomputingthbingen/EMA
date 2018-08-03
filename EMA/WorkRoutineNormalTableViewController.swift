//
//  WorkRoutineNormalTableViewController.swift
//  EMA
//
//  Created by Ertugrul Yilmaz on 25.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit
import RealmSwift

class WorkRoutineNormalTableViewController: UITableViewController {

    var items = [DatabaseModelNormalWorkingRoutine]()

    let databaseManager = DatabaseManager.shared

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        items.removeAll()
        getAllObjects()
        tableView.reloadData()
        //items = databaseManager.getObjects(type: DatabaseModelNormal)
    }

    func getAllObjects() {
        let objects = databaseManager.getObjects(type: DatabaseModelNormalWorkingRoutine.self)
            for element in objects {
                if let normal = element as? DatabaseModelNormalWorkingRoutine {
                    items.append(normal)
                }
            }
    }

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

    @objc func addButton(sender: UIBarButtonItem) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let workRoutineNormalViewController = mainStoryboard.instantiateViewController(
            withIdentifier: "WorkRoutineNormal") as? WorkRoutineNormalViewController
        workRoutineNormalViewController?.title = "Hinzufügen"
        workRoutineNormalViewController?.workState = WorkState.add
        workRoutineNormalViewController?.navigationItem.backBarButtonItem?.title = "Zurück"
        self.navigationController?.pushViewController(workRoutineNormalViewController!, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkRoutineNormalCell", for: indexPath)
            as! WorkingRoutineNormalCell // swiftlint:disable:this force_cast

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "de_DE")
        cell.dateLabel.text = dateFormatter.string(from: items[indexPath.item].date)
        cell.fieldLabel.text = items[indexPath.item].field
        cell.usernameLabel.text = items[indexPath.item].username

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            databaseManager.deleteFromDatabase(object: items[indexPath.row])
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let workRoutineNormalViewController = mainStoryboard.instantiateViewController(
            withIdentifier: "WorkRoutineNormal") as? WorkRoutineNormalViewController
        workRoutineNormalViewController?.title = "Bearbeiten"
        workRoutineNormalViewController?.workState = WorkState.edit
        workRoutineNormalViewController?.databaseModelNormal = items[indexPath.item]
        self.navigationController?.pushViewController(workRoutineNormalViewController!, animated: true)
    }

}
