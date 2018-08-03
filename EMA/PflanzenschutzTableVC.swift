//
//  PflanzenschutzTableVCTableViewController.swift
//  EMA
//
//  Created by Veli Tasyurdu on 03.08.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit

class PflanzenschutzTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        let addButton = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(add))
        self.navigationItem.rightBarButtonItem = addButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    @objc func add() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let workRoutineNormalViewController = mainStoryboard.instantiateViewController(
            withIdentifier: "Pflanzenschutz") as? PflanzenschutzViewController
        workRoutineNormalViewController?.title = "Hinzufügen"
        workRoutineNormalViewController?.navigationItem.backBarButtonItem?.title = "Zurück"
        self.navigationController?.pushViewController(workRoutineNormalViewController!, animated: true)
    }

}
