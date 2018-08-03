//
//  WorkRoutineFertilizationCell.swift
//  EMA
//
//  Created by Ertugrul Yilmaz on 03.08.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit
/**
 Klasse für die Zelle der Düngung.
 **Note :** Für weitere Informationen auf die Parameter klicken.*/
class WorkRoutineFertilizationCell: UITableViewCell {
    ///Datum
    @IBOutlet weak var dateLabel: UILabel!
    ///Feld
    @IBOutlet weak var fieldLabel: UILabel!
    ///Kategorie
    @IBOutlet weak var categoryLabel: UILabel!
    ///Name Düngemittel
    @IBOutlet weak var fertilizerLabel: UILabel!
}
