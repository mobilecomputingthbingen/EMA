//
//  MenuViewController.swift
//  EMA
//
//  Created by Ertugrul Yilmaz on 23.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit

class MenuViewController: UICollectionViewController {
    let items = ["Entlauben", "Traubenlese", "Düngung", "Pflanzenschutz", "Felder"]
    let itemBackgroundColor = [UIColor.blue, UIColor.red, UIColor.yellow, UIColor.green, UIColor.gray]

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
            print( "Düngung")
        case 3  :
            print( "Pflanzenschutz")
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

    override func viewDidLoad() {
        super.viewDidLoad()

        var screenSize: CGRect!
        var screenWidth: CGFloat!
        var itemsSize: CGFloat!

        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        itemsSize = (screenWidth - 3 * 16) / 2

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: itemsSize, height: itemsSize)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        collectionView!.collectionViewLayout = layout
        layout.headerReferenceSize = CGSize(width: 50, height: 50)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
