//
//  FieldsViewController.swift
//  EMA
//
//  Created by Veli Tasyurdu on 22.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit

class FieldsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Felder"
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
    }

}
