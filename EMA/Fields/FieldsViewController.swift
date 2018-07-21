//
//  FieldsViewController.swift
//  EMA
//
//  Created by Veli Tasyurdu on 21.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit

class FieldsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.topItem?.title = "Felder"
        
    }


}
