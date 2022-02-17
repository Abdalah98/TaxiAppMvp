//
//  MapViewVC.swift
//  Taxiapp MVP Task Alalmiya Alhura
//
//  Created by Abdallah on 2/13/22.
//

import UIKit
import MapKit
import CoreLocation


class MapViewVC: UIViewController {
    @IBOutlet weak var destinationLocationTextFiled: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var currentPlacemark:CLPlacemark?
    var currentRoute: MKRoute?
    
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    
    
    var Loaction:String?

    override func viewDidLoad() {
        super.viewDidLoad()
       
         self.hideKeyboardWhenTappedAround()
        checkLocationServices()
        mapView.delegate = self
        locationManager.delegate = self
    }
    //American University
    //MARK: - Buttons
    
    //MARK: - getMyLocationdirection
    @IBAction func getMyLocation(_ sender: Any) {
         Loaction  = destinationLocationTextFiled.text ?? ""
        self.convertAddressStringtoLocation()

    }
    func makeDirections(){
        guard let currentPlacemark = currentPlacemark else {
            return
        }
        let directionRequest = MKDirections.Request()
        // Set the source and destination of the route
        directionRequest.source = MKMapItem.forCurrentLocation()
        let destinationPlacemark = MKPlacemark(placemark: currentPlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = MKDirectionsTransportType.automobile
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (routeResponse, routeError) -> Void in
            guard let routeResponse = routeResponse else {
                if let routeError = routeError {
                    print("Error: \(routeError)")
                    self.showAlert("Location not found. Please enter the correct location")

                }
                return
            }
            let route = routeResponse.routes[0]
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)

        }

    }
}
