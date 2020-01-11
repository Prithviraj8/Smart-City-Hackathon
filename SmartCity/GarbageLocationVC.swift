//
//  GarbageLocationVC.swift
//  SmartCity
//
//  Created by Prithviraj Murthy on 20/11/19.
//  Copyright © 2019 Prithviraj Murthy. All rights reserved.
//

import UIKit
import MapKit

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}
//18.573482, 73.876825  18.572781, 73.877898  18.571723, 73.877254  18.575018, 73.876871


class GarbageLocationVC: UIViewController, MKMapViewDelegate , CLLocationManagerDelegate{
    @IBOutlet weak var mapView: MKMapView!

    var locations = [CLLocationCoordinate2D]()
    var pinTitles = [String]()
    var pinSubTitles = [String]()
    let locationManager = CLLocationManager()
    var getDirections: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
        let location = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
      
        locations.append(CLLocationCoordinate2D(latitude: 18.573482, longitude:73.876825))
        locations.append(CLLocationCoordinate2D(latitude: 18.572781, longitude:73.877898))
        locations.append(CLLocationCoordinate2D(latitude: 18.571723, longitude:73.877254))
        locations.append(CLLocationCoordinate2D(latitude: 18.575018, longitude:73.876871))
        
        pinTitles.append("Location1")
        pinTitles.append("Location2")
        pinTitles.append("Location3")
        pinTitles.append("Location4")
        
        pinSubTitles.append("Click here to get Directions")
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        self.mapView.setRegion(region, animated: true)
       
        for i in 0..<locations.count {
  
             let pin1 = customPin(pinTitle: pinTitles[i], pinSubTitle: pinSubTitles[0], location: locations[i])
             self.mapView.addAnnotation(pin1)
             self.mapView.delegate = self
        }
     
    
    }
    

       func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotationView.image = UIImage(named:"pin")
        annotationView.canShowCallout = true
        return annotationView
    }
    
    var location = CLLocationCoordinate2D()
    var garbageImg: Int = 1
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("annotation title == \(String(describing: view.annotation?.title!))")
       
        
        if view.annotation?.title! == "Location1"{
            location.latitude = locations[0].latitude
            location.longitude = locations[0].longitude
            garbageImg = 1
            performSegue(withIdentifier: "GarbageInfo", sender: self)

        }
        if view.annotation?.title! == "Location2"{
            location.latitude = locations[1].latitude
            location.longitude = locations[1].longitude
            garbageImg = 2
            performSegue(withIdentifier: "GarbageInfo", sender: self)

        }
        if view.annotation?.title! == "Location3"{
            location.latitude = locations[2].latitude
            location.longitude = locations[2].longitude
            garbageImg = 3
            performSegue(withIdentifier: "GarbageInfo", sender: self)

        }
        if view.annotation?.title! == "Location4"{
            location.latitude = locations[3].latitude
            location.longitude = locations[3].longitude
            garbageImg = 4
            performSegue(withIdentifier: "GarbageInfo", sender: self)
        }
        if view.annotation?.title! == "Location5"{
            location.latitude = locations[4].latitude
            location.longitude = locations[4].longitude
            garbageImg = 5
            performSegue(withIdentifier: "GarbageInfo", sender: self)
        }
        if view.annotation?.title! == "Location6"{
            location.latitude = locations[5].latitude
            location.longitude = locations[5].longitude
            garbageImg = 6
            performSegue(withIdentifier: "GarbageInfo", sender: self)
        }
        if view.annotation?.title! == "Location7"{
            location.latitude = locations[6].latitude
            location.longitude = locations[6].longitude
            garbageImg = 7
            performSegue(withIdentifier: "GarbageInfo", sender: self)
        }
    }
    
    
    @IBAction func getMoreLocations(_ sender: Any) {
        let center = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
       
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.040, longitudeDelta: 0.040))
        self.mapView.setRegion(region, animated: true)

        locations.append(CLLocationCoordinate2D(latitude: 18.575185, longitude:73.897061))
        locations.append(CLLocationCoordinate2D(latitude: 18.560296, longitude:73.876289))
        locations.append(CLLocationCoordinate2D(latitude: 18.568351, longitude:73.885473))
               
        pinTitles.append("Location5")
        pinTitles.append("Location6")
        pinTitles.append("Location7")
        
        
        for i in 4..<locations.count {
         
                    let pin = customPin(pinTitle: pinTitles[i], pinSubTitle: pinSubTitles[0], location: locations[i])
                    self.mapView.addAnnotation(pin)
                    self.mapView.delegate = self
               }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GarbageInfo"{
            let VC = segue.destination as! GarbageInfoVC
            
            VC.location = location
            VC.garbageImg = garbageImg
        }
    }
}
