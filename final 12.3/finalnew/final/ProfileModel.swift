//
//  ProfileModel.swift
//  final
//
//  Created by James on 2018/12/1.
//  Copyright © 2018年 James. All rights reserved.
//

import UIKit
import Foundation

class ProfileModel: NSObject {

    var username : String?
    var sex : String?
    var desc : String?
    var useremail : String?
    var birthday : String?
    var city : String?
    var image : String?
    
    
    override init() {
        
    }
    
    init(username: String, sex : String, desc : String, useremail:String, birthday:String, city:String, image:String) {
        
        self.username = username
        self.sex = sex
        self.desc = desc
        self.useremail = useremail
        self.birthday = birthday
        self.city = city
        self.image = image
    }
    
    override var description: String{
        return "Username:\(username),Sex:\(sex), Desc:\(desc), Useremail:\(useremail), Birthday:\(birthday), City:\(city), Image:\(image)"
    }
    
}
