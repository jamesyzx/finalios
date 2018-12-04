//
//  MapViewController.swift
//  final
//
//  Created by Chung-Yang Li on 12/3/18.
//  Copyright © 2018 James. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var btnIn: UIButton!
    @IBOutlet weak var btnOut: UIButton!
    
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    
    var camera = GMSCameraPosition()
    var locValue = CLLocationCoordinate2D()
    var latitude: CLLocationDegrees = 0
    var longitude: CLLocationDegrees = 0
    var zoom: Float  = 15
    
    @IBOutlet weak var viewMap: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewMap.bringSubviewToFront(btnIn)
        viewMap.bringSubviewToFront(btnOut)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
      
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

        camera = GMSCameraPosition.camera(withLatitude: 42.340375, longitude: -71.089100, zoom: zoom)
        viewMap.camera = camera

//        camera = GMSCameraPosition.camera(withLatitude: 42.340375, longitude: -71.089100, zoom: 15)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        view = mapView

        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 42.340375, longitude: -71.089100)
        marker.title = "My Location"
        marker.snippet = ""
        marker.map = viewMap

        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: 42.343492, longitude: -71.087051)
        marker2.title = "Player2"
        marker2.snippet = "rank"
        marker2.map = viewMap
        marker2.icon = GMSMarker.markerImage(with: .green)

        let marker3 = GMSMarker()
        marker3.position = CLLocationCoordinate2D(latitude: 42.338425, longitude: -71.087813)
        marker3.title = "Player3"
        marker3.snippet = "Rank"
        marker3.map = viewMap
        marker3.icon = GMSMarker.markerImage(with: .green)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func zoomIn(_ sender: UIButton) {
        zoom = zoom + 1
        self.viewMap.animate(toZoom: zoom)
    }
    @IBAction func zoomOut(_ sender: UIButton) {
        zoom = zoom - 1
        self.viewMap.animate(toZoom: zoom)
    }
    
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            viewMap.isMyLocationEnabled = true
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        latitude = locValue.latitude
        longitude = locValue.longitude
        
        camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 15)
        viewMap.camera = camera
        
      
        
    }
    
    
}
