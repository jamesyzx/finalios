//
//  Location.swift
//  final
//
//  Created by James on 2018/12/4.
//  Copyright © 2018年 James. All rights reserved.
//

import UIKit
import Foundation

class Location: NSObject {

    var useremail : String?
    var city : String?
    var latitude : String?
    var longitude : String?
    
    override init() {
        
    }
    
    init( useremail:String, longitude:String, city:String, latitude:String) {
        
        
        self.useremail = useremail
      
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
    }
    
    override var description: String{
        return "Useremail:\(useremail), Longitude:\(longitude), City:\(city), Latitude:\(latitude)"
    }
    
}
