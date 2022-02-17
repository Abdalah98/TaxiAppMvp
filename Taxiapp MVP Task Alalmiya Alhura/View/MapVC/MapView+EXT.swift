//
//  MapView+EXT.swift
//  Taxiapp MVP Task Alalmiya Alhura
//
//  Created by Abdallah on 2/17/22.
//

import UIKit
import MapKit
//MARK: - mapDelegate

// MARK: - MKMapViewDelegate methods
extension MapViewVC :MKMapViewDelegate{
    func convertAddressStringtoLocation()
    {
            //   Request for a user's authorization for location services
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.authorizedWhenInUse { mapView.showsUserLocation = true
        }
        
        //
        /*The framework provides a Geocoder class for developers to convert a textual address, known as placemark, into global coordinates. This process is usually referred to forward geocoding. Conversely, you can use Geocoder to convert latitude and longtitude values back to a placemark. This process is known as reverse geocoding.*/
        
        // Convert address to coordinate and annotate it on map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(Loaction ?? "", completionHandler: { placemarks, error in
            if let error = error {
                print(error,"err geoCoder")
                self.showAlert("Location not found. Please enter the correct location")

                return
            }
            
            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]
                self.currentPlacemark = placemark
                // Add annotation
                //We convert the address into a coordinate for annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.Loaction
                self.makeDirections()

                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    // Display the annotation
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        })
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        // Reuse the annotation if possible
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        // Pin color customization based on the type of annotation
        if let currentPlacemarkCoordinate = currentPlacemark?.location?.coordinate {
            if currentPlacemarkCoordinate.latitude == annotation.coordinate.latitude &&
                currentPlacemarkCoordinate.longitude == annotation.coordinate.longitude {
   
                // Pin color customization
                annotationView?.pinTintColor = UIColor.orange
                
            } else {
                // Pin color customization
                annotationView?.pinTintColor = UIColor.red
            }
        }
        
        annotationView?.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
        return annotationView
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 3.0
        return renderer
    }
}
