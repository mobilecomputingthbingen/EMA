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

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var fields: Results<Object>?
    var canDrawField: Bool = false {
        didSet {
            if canDrawField {
                self.navigationController?.navigationBar.topItem?.title = "Feld anlegen"
                let saveButton = UIBarButtonItem(image: UIImage(named: "check"), style: .plain, target: self, action: #selector(saveField))
                self.navigationController?.navigationBar.topItem?.rightBarButtonItem = saveButton
            } else {
                self.navigationController?.navigationBar.topItem?.title = "Karte"
                let addButton = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: nil)
                self.navigationController?.navigationBar.topItem?.rightBarButtonItem = addButton
            }
        }
    }
    @IBOutlet weak var mapView: MKMapView!
    var points = [CLLocationCoordinate2D]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fields = DatabaseManager.shared.getObjects(type: Field.self)
        drawFieldsOnMap()
        self.mapView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Karte"
        let addButton = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(addField))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = addButton
    }
    @objc private func addField() {
        canDrawField = true
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if canDrawField {
            if let touch = touches.first {
                let coordinate = mapView.convert(touch.location(in: mapView), toCoordinateFrom: mapView)
                points.append(coordinate)
                if points.count < 3 {
                    let polyline = MKPolyline(coordinates: &points, count: points.count)
                    mapView.add(polyline)
                } else {
                    mapView.removeOverlays(mapView.overlays)
                    let polygon = MKPolygon(coordinates: &points, count: points.count)
                    mapView.add(polygon)
                    print("\(getSizeOfField()) FieldSize")
                }

            }
        }
    }
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
            let saveAction = UIAlertAction(title: "Speichern", style: .default) { (alert) in
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
        } else {
            alert(message: "Feldname oder Reben Sorte darf nicht leer sein")
        }
    }
    private func drawFieldsOnMap() {
        var fieldPoints = [CLLocationCoordinate2D]()
        for field in fields! {
            guard let field = field as? Field else { return }
            for position in field.position {
                let lat = position.latitude
                let long = position.longitude
                print(position.latitude)
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                fieldPoints.append(coordinate)
                print(fieldPoints)
                let polygon = MKPolygon(coordinates: &fieldPoints, count: fieldPoints.count)
                self.mapView.add(polygon)
                fieldPoints.removeAll()
            }
        }
    }
    private func getCenterOfField() -> CLLocationCoordinate2D {
        var xVal: Float = 0.0
        var yVal: Float = 0.0
        var zVal: Float = 0.0
        for points in points {
            let lat = GLKMathDegreesToRadians(Float(points.latitude))
            let long = GLKMathDegreesToRadians(Float(points.longitude))
            xVal += cos(lat) * cos(long)
            yVal += cos(lat) * sin(long)
            zVal += sin(lat)
        }
        xVal /= Float(points.count)
        yVal /= Float(points.count)
        zVal /= Float(points.count)
        let resLong = atan2f(yVal, xVal)
        let resHyp = sqrtf(xVal * xVal + yVal * yVal)
        let resLat = atan2f(zVal, resHyp)
        let result = CLLocationCoordinate2D(latitude: CLLocationDegrees(GLKMathRadiansToDegrees(resLat)), longitude: CLLocationDegrees(GLKMathRadiansToDegrees(resLong)))
        return result
    }
    let kEarthRadius = 6378137.0
    // CLLocationCoordinate2D uses degrees but we need radians
    func radians(degrees: Double) -> Double {
        return degrees * .pi / 180
    }
    private func getSizeOfField() -> Double {
        guard points.count > 2 else { return 0 }
        var area = 0.0
        for index in 0..<points.count {
            let point1 = points[index > 0 ? index - 1 : points.count - 1]
            let point2 = points[index]
            area += radians(degrees: point2.longitude - point1.longitude) * (2 + sin(radians(degrees: point1.latitude)) + sin(radians(degrees: point2.latitude)))
        }
        area = -(area * kEarthRadius * kEarthRadius / 2)
        return max(area, -area)
    }
    private func alert(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Schließen", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }

}
