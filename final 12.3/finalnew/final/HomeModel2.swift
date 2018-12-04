//
//  HomeModel2.swift
//  final
//
//  Created by James on 2018/12/2.
//  Copyright © 2018年 James. All rights reserved.
//

import UIKit


protocol HomeModelProtocol2: class {
    func itemDownloaded2(items:NSArray)
}
class HomeModel2: NSObject, URLSessionDataDelegate{
    
    weak var delegate: HomeModelProtocol2!
    func downloadItemssearch(useremail:String,sex:String,gamename:String, city:String,rank:String) {
        print("333")
        let urlPath : String = "http://localhost:8080/webios/searchGameInformation.htm?useremail=\(useremail)&sex=\(sex)&gamename=\(gamename)&city=\(city)&rank=\(rank)"
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
    
    func downloadItems(useremail:String) {
        print("222")
        let urlPath : String = "http://localhost:8080/webios/getGameInformation.htm?useremail=\(useremail)"
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
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            print(jsonResult)
        } catch let error as NSError {
            print(error)
            
        }
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
      
        for i in 0 ..< jsonResult.count
        {
          
            jsonElement = jsonResult[i] as! NSDictionary
           
            let game = GameModel()
             //"Useremail:\(useremail),Gamename:\(gamename),Userid:\(userid),Rank:\(rank)"
            //the following insures none of the JsonElement values are nil through optional binding
            if let gamename = jsonElement.value(forKey: "Gamename") as? String,
              
                let rank = jsonElement.value(forKey: "Rank")as? String,

             let useremail = jsonElement.value(forKey: "useremail") as? String,

               let userid = jsonElement.value(forKey: "userID") as? String
                
            {
                
                game.gamename = gamename
               game.useremail = useremail
                game.rank = rank
                game.userid = userid
               
            }
            
            locations.add(game)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
           self.delegate.itemDownloaded2(items: locations)
            
        })
    }
    
    // description
    //api 
    func downloadItemsallDescription() {
        print("444")
        let urlPath : String = "http://localhost:8080/webios/getDescription.htm"
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                
                self.parseJSONarray(data!)
            }
            
        }
        
        task.resume()
    }
    
    
    
    func parseJSONarray(_ data:Data) {
        print(data)
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            print(jsonResult)
        } catch let error as NSError {
            print(error)
            
        }
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let profile = ProfileModel()
            
            if let useremail = jsonElement.value(forKey: "useremail") as? String,
                
                let desc = jsonElement.value(forKey: "description")as? String
                
                
                
            {
                profile.useremail = useremail
                profile.desc = desc
              
                
            }
            
            locations.add(profile)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemDownloaded2(items: locations)
            
        })
    }
    //description
}



