//
//  GarbageInfoVC.swift
//  SmartCity
//
//  Created by Prithviraj Murthy on 22/11/19.
//  Copyright © 2019 Prithviraj Murthy. All rights reserved.
//

import UIKit
import MapKit
class GarbageInfoVC: UIViewController,CLLocationManagerDelegate {
    var location = CLLocationCoordinate2D()
    let locationManager = CLLocationManager()
    var garbageImg: Int = 1

    
    @IBOutlet weak var garbage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

        garbage.image = UIImage(named: "garbage\(garbageImg)")

    }
    
   
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func getDirections(_ sender: Any) {
        print("LOCLAT \(location.latitude)")
        getDirections(location: location)

    }
    
    func getDirections(location: CLLocationCoordinate2D) {
        let sourceCoordinates = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
    let ShopCoordinates = CLLocationCoordinate2D(latitude: (location.latitude), longitude: location.longitude)
                let regionDistance : CLLocationDistance = 1000
                let regionSpan = MKCoordinateRegion(center: ShopCoordinates,latitudinalMeters: regionDistance,longitudinalMeters: regionDistance)
                
        //        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapCenterKey: NSValue(mkCoordinateSpan: regionSpan.span)]
                
                let launchOptions:NSDictionary = NSDictionary(object: MKLaunchOptionsDirectionsModeDriving, forKey: MKLaunchOptionsDirectionsModeKey as NSCopying)

                let sourceMarker = MKPlacemark(coordinate: sourceCoordinates)
                let sourceItem = MKMapItem(placemark: sourceMarker)
                let ShopMarker = MKPlacemark(coordinate: ShopCoordinates)
                let mapItem = MKMapItem(placemark: ShopMarker)
                
                let directionRequest = MKDirections.Request()
                directionRequest.source = sourceItem
                directionRequest.destination = mapItem
                directionRequest.transportType = .automobile
                
                let directions = MKDirections(request: directionRequest)
                directions.calculate { (response, error) in
                    guard let response = response else {
                        if let error = error {
                            print("WRONG")
                        }
                        return
                    }
                    let route = response.routes[0]
        //            self.mapkitView.addOverlay(route.polyline,level: .aboveRoads)
                    
                    let rekt = route.polyline.boundingMapRect
        //            self.mapkitView.setRegion(MKCoordinateRegion(rekt),animated: true)
                }
                
                mapItem.name = "Garbage here"
                mapItem.openInMaps(launchOptions: launchOptions as! [String : Any])
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "directions"{
            let VC = segue.destination as! GarbageLocationVC
            VC.getDirections = true
        }
    }
}
