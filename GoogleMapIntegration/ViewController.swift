//
//  ViewController.swift
//  GoogleMapIntegration
//
//  Created by SpaceBasic on 23/10/17.
//  Copyright © 2017 SpaceBasic. All rights reserved.
//

import UIKit
import GoogleMaps

class VacationDestination: NSObject {
    
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Float) {
        self.name = name
        self.location = location
        self.zoom = zoom
    }
    
}

class ViewController: UIViewController {
    
    var mapView: GMSMapView?
    
    var currentDestination: VacationDestination?
    
    let destinations = [VacationDestination(name: "Chennai", location: CLLocationCoordinate2DMake(13.0827, 80.2707), zoom: 14), VacationDestination(name: "Bangalore", location: CLLocationCoordinate2DMake(12.9716, 12.9716), zoom: 18), VacationDestination(name: "Pune", location: CLLocationCoordinate2DMake(18.5204, 73.8567), zoom: 15), VacationDestination(name: "Hyderabad", location: CLLocationCoordinate2DMake(17.3850, 17.3850), zoom: 15), VacationDestination(name: "Delhi", location: CLLocationCoordinate2DMake(28.7041, 28.7041), zoom: 13)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyA6yosKqZ6kwDgUP5M7rnzdVYo5dHCXNSQ")
        let camera = GMSCameraPosition.camera(withLatitude: 13.0827, longitude: 80.2707, zoom: 12)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(13.0827, 80.2707)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "Indra gandhi airport,Chennai"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: Selector(("next")))
    }
    
    @objc func next() {
        
        if currentDestination == nil {
            currentDestination = destinations.first
        } else {
            if let index = destinations.index(of: currentDestination!), index < destinations.count - 1 {
                currentDestination = destinations[index + 1]
            }
        }
        
        setMapCamera()
    }
    
    private func setMapCamera() {
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom))
        CATransaction.commit()
        
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination?.name
        marker.map = mapView
    }
    
}

