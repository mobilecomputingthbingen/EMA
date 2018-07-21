//
//  MapViewController.swift
//  EMA
//
//  Created by Veli Tasyurdu on 21.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    private func setupView() {
        
        //MapView
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true

        
        
        self.navigationController?.navigationBar.topItem?.title = "Karte"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = addButton
    }



}
