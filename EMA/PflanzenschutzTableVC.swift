//
//  PflanzenschutzTableVC.swift
//  EMA
//
//  Created by Veli Tasyurdu on 03.08.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit
/**
 Klasse für den Pflanzenschutz.
 **Note :** Für weitere Informationen auf die Parameter klicken.*/
class PflanzenschutzTableVC: UITableViewController {
    ///Funktion für das Laden der View.
    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(image: UIImage(named: "add"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(add))
        self.navigationItem.rightBarButtonItem = addButton
    }
    ///Anzahl der Sektionen
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    ///Anzahl der Zeilen
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    ///Funktion für das Hinzufügen.
    @objc func add() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let workRoutineNormalViewController = mainStoryboard.instantiateViewController(
            withIdentifier: "Pflanzenschutz") as? PflanzenschutzViewController
        workRoutineNormalViewController?.title = "Hinzufügen"
        workRoutineNormalViewController?.navigationItem.backBarButtonItem?.title = "Zurück"
        self.navigationController?.pushViewController(workRoutineNormalViewController!, animated: true)
    }
}
