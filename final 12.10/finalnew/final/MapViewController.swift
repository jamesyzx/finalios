//
//  MapViewController.swift
//  final
//
//  Created by Chung-Yang Li on 12/3/18.
//  Copyright © 2018 James. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate, HomeModelProtocol2,UINavigationControllerDelegate{
    @IBOutlet weak var btnIn: UIButton!
    @IBOutlet weak var btnOut: UIButton!
    
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    var useremail = ""
    var camera = GMSCameraPosition()
    var locValue = CLLocationCoordinate2D()
    var latitude: CLLocationDegrees = 0
    var longitude: CLLocationDegrees = 0
    var zoom: Float  = 15
    
    @IBOutlet weak var viewMap: GMSMapView!
    
    
    
    
    var LocationItems : NSArray = NSArray()
    var location:Location = Location()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewMap.bringSubviewToFront(btnIn)
        viewMap.bringSubviewToFront(btnOut)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
      
        let home2 = HomeModel2()
        home2.delegate = self
        home2.downloadlocation()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }

        camera = GMSCameraPosition.camera(withLatitude: 42.340375, longitude: -71.089100, zoom: zoom)
        viewMap.camera = camera



        
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
        
       
    }
    
    
    
    func itemDownloaded2(items: NSArray) {
        print("items5555\(items)")
        
        LocationItems = items
       
       
    }
        
        
        
    

   
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
    
    // Location Changed
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        latitude = locValue.latitude
        longitude = locValue.longitude
        
        addLocation(longtitude: locValue.longitude, latitude:locValue.latitude, useremail: useremail)
        
        camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 15)
        viewMap.camera = camera
        
        
        viewMap.clear()
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        marker.title = "My Location"
        marker.snippet = "\(useremail)"
        marker.map = viewMap
       
        
        for i in 0 ..< LocationItems.count
        {
            
            
            let item: Location = LocationItems[i] as! Location
            
            
            let lat = (item.latitude as! NSString).doubleValue
            let lon = (item.longitude as! NSString).doubleValue
            if item.useremail != useremail
            {
            let marker2 = GMSMarker()
            marker2.position = CLLocationCoordinate2D(latitude: lat,longitude: lon)
            marker2.title = "\(item.useremail!)"
            print(item.useremail!)
            marker2.snippet = ""
            marker2.map = viewMap
            marker2.icon = GMSMarker.markerImage(with: .green)
            
            }
        }
        
    }
    
    func addLocation(longtitude:Double,latitude:Double,useremail:String)
    {
        let url = URL(string: "http://localhost:8080/webios/addlocation.htm")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "useremail=\(useremail)&latitude=\(latitude)&longitude=\(longitude)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error!)")
                return
            }
            print(data)
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            
        }
        task.resume()
    }
    
    
    
    
    
}
