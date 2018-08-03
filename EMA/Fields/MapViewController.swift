//
//  MapViewController.swift
//  EMA
//
//  Created by Veli Tasyurdu on 22.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import UIKit
import MapKit
import GLKit
import RealmSwift
/**
 Klasse für das Erstellen der Felder auf der Karte.
 **Note :** Für weitere Informationen auf die Parameter klicken.*/
class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    ///Variable für alle Felder in der DB.
    var fields: Results<Object>?
    ///Variable für den Button Zürück
    var backButton = UIBarButtonItem()
    ///Boolvariable für das Zeichnen der Felder.
    var canDrawField: Bool = false {
        didSet {
            if canDrawField {
                self.tabBarController?.title = "Feld anlegen"
                let saveButton = UIBarButtonItem(image: UIImage(named: "check"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(saveField))
                let cancelButton = UIBarButtonItem(title: "Abbrechen",
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(cancelCreation))
                self.tabBarController?.navigationItem.rightBarButtonItem = saveButton
                self.tabBarController?.navigationItem.leftBarButtonItem = cancelButton
                savedDrawnField = false
            } else {
                self.tabBarController?.title = "Karte"
                let addButton = UIBarButtonItem(image: UIImage(named: "add"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(addField))
                self.tabBarController?.navigationItem.rightBarButtonItem = addButton
                self.tabBarController?.navigationItem.leftBarButtonItem = nil
            }
        }
    }
    ///Variable der Map
    @IBOutlet weak var mapView: MKMapView!
    ///Punkte der Positionen auf der Karte.
    var points = [CLLocationCoordinate2D]()
    ///Anzeigen der View
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fields = DatabaseManager.shared.getObjects(type: Field.self)
        drawFieldsOnMap()
        self.mapView.delegate = self
        self.tabBarController?.title = "Karte"
    }
    ///Erscheinen des Views
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let addButton = UIBarButtonItem(image: UIImage(named: "add"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(addField))
        self.tabBarController?.navigationItem.rightBarButtonItem = addButton
    }
    ///Hinzufügen eines Feldes
    @objc private func addField() {
        canDrawField = true
    }
    ///Geste zum Zeichnen
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if canDrawField {
            if let touch = touches.first {
                let coordinate = mapView.convert(touch.location(in: mapView), toCoordinateFrom: mapView)
                points.append(coordinate)
                if points.count < 3 {
                    let polyline = MKPolyline(coordinates: &points, count: points.count)
                    mapView.add(polyline)
                } else {
                    if let lastOverlay = self.mapView.overlays.last {
                        self.mapView.remove(lastOverlay)
                    }
                    let polygon = MKPolygon(coordinates: &points, count: points.count)
                    mapView.add(polygon)
                    print("\(getSizeOfField()) FieldSize")
                }
            }
        }
    }
    ///Rendering der Felder als Zeichenobjekte
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.magenta
            polylineRenderer.lineWidth = 2
            return polylineRenderer
        } else if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            polygonView.fillColor = UIColor.magenta.withAlphaComponent(0.5)
            polygonView.strokeColor = UIColor.magenta
            polygonView.lineWidth = 2
            return polygonView
        }
        return MKPolylineRenderer(overlay: overlay)
    }
    ///Speichern des Feldes in die Zwischenablage
    @objc private func saveField() {
        if points.count < 3 {
            alert(message: "Lege min. 3 Punkte an")
        } else {
            let alertController = UIAlertController(title: "Feld speichern", message: nil, preferredStyle: .alert)
            alertController.addTextField { (textField) in
                textField.placeholder = "Feldname"
            }
            alertController.addTextField { (textField) in
                textField.placeholder = "Rebensorte"
            }
            let saveAction = UIAlertAction(title: "Speichern", style: .default) { (_) in
                let nameTextField = alertController.textFields![0] as UITextField
                let sortTextField = alertController.textFields![1] as UITextField
                self.saveToDB(name: nameTextField.text!, sort: sortTextField.text!)
            }
            let cancelAction = UIAlertAction(title: "Abbrechen", style: .cancel, handler: nil)
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    ///Speichern in die DB.
    @objc private func saveToDB(name: String, sort: String) {
        if !name.isEmpty || !sort.isEmpty {
            let field: Field = Field()
            field.name = name
            field.sort = sort
            field.size = getSizeOfField()
            for point in points {
                let location = Location()
                location.latitude = Double(point.latitude)
                location.longitude = Double(point.longitude)
                field.position.append(location)
            }
            DatabaseManager.shared.addToDatabase(object: field)
            self.canDrawField = false
            self.view.setNeedsDisplay()
            self.points.removeAll()
            savedDrawnField = true
        } else {
            alert(message: "Feldname oder Reben Sorte darf nicht leer sein")
        }
    }
    ///Zeichnen auf die Karte
    private func drawFieldsOnMap() {
        var fieldPoints = [CLLocationCoordinate2D]()
        for field in fields! {
            if let field = field as? Field {
                for position in field.position {
                    let lat = position.latitude
                    let long = position.longitude
                    print(position.latitude)
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    fieldPoints.append(coordinate)
                    print(fieldPoints)
                    let polygon = MKPolygon(coordinates: &fieldPoints, count: fieldPoints.count)
                    self.mapView.add(polygon)
                }
                fieldPoints.removeAll()
            }
        }
    }
    ///Radius für die Erde
    let kEarthRadius = 6378137.0
    /// Hilfsfunktion für das Errechnen von Radius auf Grad
    func radians(degrees: Double) -> Double {
        return degrees * .pi / 180
    }
    ///Funktion für die Größe eines Feldes.
    private func getSizeOfField() -> Double {
        guard points.count > 2 else { return 0 }
        var area = 0.0
        for index in 0..<points.count {
            let point1 = points[index > 0 ? index - 1 : points.count - 1]
            let point2 = points[index]
            area += radians(degrees: point2.longitude - point1.longitude) * (2 + sin(radians(degrees: point1.latitude))
                + sin(radians(degrees: point2.latitude)))
        }
        area = -(area * kEarthRadius * kEarthRadius / 2)
        return max(area, -area)
    }
    ///Funktion zum Anzeigen einer Nachricht.
    private func alert(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Schließen", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
   ///Variable für das zwischenpeichern
    private var savedDrawnField = false
    ///Funktion für das Abbrechen der Zeichnung
    @objc private func cancelCreation() {
        self.canDrawField = false
        if let lastOverlay = self.mapView.overlays.last {
            if !savedDrawnField {
                self.mapView.remove(lastOverlay)
            }
        }
    }
}
