//
//  TraubenleseCell.swift
//  EMA
//
//  Created by Mustafa Sahinli on 31.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import Foundation

import UIKit
/**
 Klasse für die Zelle der Traubenlese.
 **Note :** Für weitere Informationen auf die Parameter klicken.*/
class TraubenleseCell: UITableViewCell {
    ///Datum
    @IBOutlet weak var dateLabel: UILabel!
    ///Feld
    @IBOutlet weak var fieldLabel: UILabel!
    ///Username
    @IBOutlet weak var usernameLabel: UILabel!
    ///Gearbeitete Stunden
    @IBOutlet weak var workHourLabel: UILabel!
}
