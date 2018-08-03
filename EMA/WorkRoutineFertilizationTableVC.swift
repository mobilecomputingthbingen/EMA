//
//  WorkRoutineFertilizationTableViewController.swift
//  EMA
//
//  Created by Ertugrul Yilmaz on 03.08.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit

class WorkRoutineFertilizationTableVC: UITableViewController {

    var items = [DatabaseModelFertilization]()

    let databaseManager = DatabaseManager.shared

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        items.removeAll()
        getAllObjects()
        tableView.reloadData()
    }

    func getAllObjects() {
        let objects = databaseManager.getObjects(type: DatabaseModelFertilization.self)
        for element in objects {
            if let item = element as? DatabaseModelFertilization {
                items.append(item)
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
        let workRoutineFertilizationViewController = mainStoryboard.instantiateViewController(
            withIdentifier: "WorkRoutineFertilization") as? WorkRoutineFertilizationViewController
        workRoutineFertilizationViewController?.title = "Hinzufügen"
        workRoutineFertilizationViewController?.workState = WorkState.add
        workRoutineFertilizationViewController?.navigationItem.backBarButtonItem?.title = "Zurück"
        self.navigationController?.pushViewController(workRoutineFertilizationViewController!, animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkRoutineFertilizationCell", for: indexPath)
            as! WorkRoutineFertilizationCell // swiftlint:disable:this force_cast

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "de_DE")
        cell.dateLabel.text = dateFormatter.string(from: items[indexPath.item].date)
        cell.fieldLabel.text = items[indexPath.item].field
        cell.categoryLabel.text = items[indexPath.item].category
        cell.fertilizerLabel.text = items[indexPath.item].fertilize

        return cell
    }

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
        let workRoutineFertilizationViewController = mainStoryboard.instantiateViewController(
            withIdentifier: "WorkRoutineFertilization") as? WorkRoutineFertilizationViewController
        workRoutineFertilizationViewController?.title = "Bearbeiten"
        workRoutineFertilizationViewController?.workState = WorkState.edit
        workRoutineFertilizationViewController?.databaseModelFertilization = items[indexPath.item]
        self.navigationController?.pushViewController(workRoutineFertilizationViewController!, animated: true)
    }

}
