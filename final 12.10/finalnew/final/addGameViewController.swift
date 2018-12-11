//
//  addGameViewController.swift
//  final
//
//  Created by James on 2018/12/5.
//  Copyright © 2018年 James. All rights reserved.
//

import UIKit
import DropDown
class addGameViewController: UIViewController {
    var useremail = ""
    let gameDrop = DropDown()
    let rankDrop = DropDown()
    @IBOutlet weak var gameView: UIView!
    
    @IBOutlet weak var rankView: UIView!
    @IBOutlet weak var useridTxt: UITextField!
    

    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var gameBtn: UIButton!
    @IBOutlet weak var rankBtn: UIButton!
    var time = 0;
    var oldgamename = ""
    var oldrank = ""
    var olduserid = ""
    var gameid = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setGameDrop()
        setRankDrop()
        if time != 0
        {
            addBtn.isHidden = true
            gameBtn.setTitle(oldgamename, for: .normal)
            rankBtn.setTitle(oldrank, for: .normal)
            useridTxt.text = olduserid
            gameBtn.isEnabled = false
            rankBtn.isEnabled = false
            updateBtn.isHidden = false
        }
        print("gameid:\(gameid)")
        
        // Background
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "white")?.draw(in: self.view.bounds)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            
            
            
            self.view.backgroundColor = UIColor(patternImage: image)
        }else{
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
        }
        // Do any additional setup after loading the view.
    }
    func setGameDrop(){
        // The view to which the drop down will appear on
        gameDrop.anchorView = gameView // UIView or UIBarButtonItem
        
        // The list of items to display. Can be changed dynamically
        gameDrop.dataSource = ["AoV", "PUBG", "Hearthstone"]
        
        //        DropDown.startListeningToKeyboard()
        gameDrop.selectionAction = { [weak self] (index, item) in
            self?.gameBtn.setTitle(item, for: .normal)
        }
    }
    
    func setRankDrop(){
        rankDrop.anchorView = rankView
        rankDrop.dataSource = ["1", "2", "3", "4", "5"]
        //        DropDown.startListeningToKeyboard()
        rankDrop.selectionAction = { [weak self] (index, item) in
            self?.rankBtn.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func gameAction(_ sender: UIButton) {
        gameDrop.show()
    }
    
    @IBAction func rankAction(_ sender: UIButton) {
        rankDrop.show()
    }
    
   
    @IBAction func updateAction(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Please enter correct!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        var game = ""
        var rank = ""
        var userid = ""
        userid = useridTxt.text!
        game = (gameBtn.titleLabel?.text)!
        rank = (rankBtn.titleLabel?.text)!
        
        if !userid.isAlphaNumSpace(ignoreDiacritics: true){  alert.show();  return}
        if game == "" {  alert.show();  return}
        if rank == "" {  alert.show();  return}
        
        
        let alert1 = UIAlertController(title: "Update Success", message: "", preferredStyle: UIAlertController.Style.alert)
        self.updategame(gamename: game, rank: rank, userid: userid, useremail: useremail,id:gameid)
        alert1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert1.show()
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Please enter correct!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        var game = ""
        var rank = ""
        var userid = ""
        userid = useridTxt.text!
        game = (gameBtn.titleLabel?.text)!
        rank = (rankBtn.titleLabel?.text)!
        
        if !userid.isAlphaNumSpace(ignoreDiacritics: true) {  alert.show();  return}
         if game == "" {  alert.show();  return}
         if rank == "" {  alert.show();  return}
        self.addgame(gamename: game, rank: rank, userid: userid, useremail: useremail)
        
       let alert1 = UIAlertController(title: "Add Success", message: "", preferredStyle: UIAlertController.Style.alert)
        
     alert1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert1.show()

    
    }
    func addgame(gamename:String,rank:String,userid:String,useremail:String)
    {
        let url = URL(string: "http://localhost:8080/webios/addgame.htm")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "gamename=\(gamename)&rank=\(rank)&userid=\(userid)&useremail=\(useremail)"
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
    func updategame(gamename:String,rank:String,userid:String,useremail:String,id:String)
    {
        let url = URL(string: "http://localhost:8080/webios/updategame.htm")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "gamename=\(gamename)&rank=\(rank)&userid=\(userid)&useremail=\(useremail)&id=\(id)"
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
