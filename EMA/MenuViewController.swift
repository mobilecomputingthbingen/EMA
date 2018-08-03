//
//  MenuViewController.swift
//  EMA
//
//  Created by Ertugrul Yilmaz on 23.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//  Changed by Mustafa Sahinli on 30.07.18 

import UIKit
/**
 Klasse für die Anzeige des Views nach der Anmeldung mit , sowie Definierung von mehreren Parametern.
 **Note :** Für weitere Informationen auf die Parameter klicken.*/
class MenuViewController: UICollectionViewController {
    ///Feld für die Items der Farben
    let items = ["Entlauben", "Traubenlese", "Düngung", "Pflanzenschutz", "Felder"]
    /// Feld für die Farben der Anzeigenamen -> Bsp : Entlauben -> rot
    let itemBackgroundColor = [UIColor.blue, UIColor.red, UIColor.yellow, UIColor.green, UIColor.gray]///

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { //
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                as! MenuCollectionViewCell // swiftlint:disable:this force_cast
            cell.label.text = items[indexPath.item]
            cell.backgroundColor = itemBackgroundColor[indexPath.item]
            return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0  :
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let workRoutineNormalTableViewController = mainStoryboard.instantiateViewController(
                withIdentifier: "WorkRoutineNormalTable") as? WorkRoutineNormalTableViewController
            self.navigationController?.pushViewController(workRoutineNormalTableViewController!, animated: true)
        case 1  :
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let traubenleseTableViewController = mainStoryboard.instantiateViewController(
                withIdentifier: "TraubenleseTable") as? TraubenleseTableViewController
            self.navigationController?.pushViewController(traubenleseTableViewController!, animated: true)
            
        case 2  :
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let workRoutineFertTableViewController = mainStoryboard.instantiateViewController(
                withIdentifier: "WorkRoutineFertilizationTable") as? WorkRoutineFertilizationTableVC
            self.navigationController?.pushViewController(workRoutineFertTableViewController!, animated: true)
        case 3  :
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
           // let pflanzenschutzNormalTableViewController = mainStoryboard.instantiateViewController(
            //    withIdentifier: "PflanzenschutzNormalTable") as? PflanzenschutzTableVC
            //self.navigationController?.pushViewController(pflanzenschutzNormalTableViewController!, animated: true)
        case 4  :
            performSegue(withIdentifier: "showMap", sender: self)
        default :
            print( "default")
        }
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionElementKindSectionHeader,
            withReuseIdentifier: "SectionHeaderView", for: indexPath)
            as! SectionHeaderView // swiftlint:disable:this force_cast
        sectionHeaderView.label.text = "Wählen Sie einen Vorgang aus"
        return sectionHeaderView
    }

    override func viewDidLoad() { // Methode für das Laden der View
        super.viewDidLoad()
        var screenSize: CGRect!
        var screenWidth: CGFloat!
        var itemsSize: CGFloat!

        screenSize = UIScreen.main.bounds //Size of Screen
        screenWidth = screenSize.width //Width of Screen
        itemsSize = (screenWidth - 3 * 16) / 2

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout() //Parameter of Layout
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: itemsSize, height: itemsSize) //Item size
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        collectionView!.collectionViewLayout = layout
        layout.headerReferenceSize = CGSize(width: 50, height: 50)
    }

    override func didReceiveMemoryWarning() { //Function for Receiving Memory Warning
        super.didReceiveMemoryWarning()
    }
}
