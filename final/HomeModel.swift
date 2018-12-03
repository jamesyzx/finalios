//
//  HomeModel.swift
//  final
//
//  Created by James on 2018/12/1.
//  Copyright © 2018年 James. All rights reserved.
//

import UIKit
import Foundation

protocol HomeModelProtocol: class {
    func itemDownloaded(items:NSArray)
}

class HomeModel: NSObject , URLSessionDataDelegate{
    
    weak var delegate: HomeModelProtocol!
    func downloadItems(useremail:String) {
        print("!!1")
        let urlPath : String = "http://localhost:8080/webios//getUserInformation.htm?useremail=\(useremail)"
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }
    func parseJSON(_ data:Data) {
        print(data)
        var jsonResult = NSDictionary()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            print(jsonResult)
        } catch let error as NSError {
            print(error)
            
        }
        
        let locations = NSMutableArray()
        let profile = ProfileModel()
        print(jsonResult)
        //the following insures none of the JsonElement values are nil through optional binding
        if let username = jsonResult.value(forKey: "username")as? String,
            let sex = jsonResult.value(forKey: "sex")as? String,
            let desc = jsonResult.value(forKey: "description")as? String,
            let useremail = jsonResult.value(forKey: "useremail") as?String,
            let birthday = jsonResult.value(forKey: "birthday") as? String,
            let city = jsonResult.value(forKey: "city") as? String,
            let image = jsonResult.value(forKey: "image") as? String
        {
            print("weqewq")
            print(useremail)
            profile.username = username
            
            profile.sex = sex
            profile.desc = desc
            profile.useremail = useremail
            profile.city = city
            profile.birthday = birthday
            profile.image = image
            
            
        }
        print("profile:\(profile)")
        locations.add(profile)
        print(locations)
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemDownloaded(items: locations)
            
        })
    }
}
