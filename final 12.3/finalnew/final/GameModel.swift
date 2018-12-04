//
//  GameModel.swift
//  final
//
//  Created by James on 2018/12/2.
//  Copyright © 2018年 James. All rights reserved.
//

import UIKit
import Foundation

class GameModel: NSObject {

    
    var useremail : String?
    var gamename: String?
    var userid : String?
    var rank :String?
    
    
    override init() {
        
    }
    
    
    init(useremail:String, gamename:String, userid:String, rank : String) {
        self.useremail = useremail
        self.gamename = gamename
        self.userid = userid
        self.rank = rank
    }
    
    
    override var description: String{
        return "Useremail:\(useremail),Gamename:\(gamename),Userid:\(userid),Rank:\(rank)"
    }
    
    
}
