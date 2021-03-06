//
//  MatchViewController.swift
//  final
//
//  Created by James on 2018/12/3.
//  Copyright © 2018年 James. All rights reserved.
//

import UIKit
import DropDown

class MatchViewController: UIViewController,HomeModelProtocol2,UINavigationControllerDelegate ,UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate{

    var gameItems : NSArray = NSArray()
    var useremail  = ""

    let gameDrop = DropDown()
    let rankDrop = DropDown()
    let sexDrop = DropDown()
    let cityDrop = DropDown()
    
    @IBAction func btnGame(_ sender: UIButton) {
        gameDrop.show()
    }
    @IBAction func btnRank(_ sender: UIButton) {
        rankDrop.show()
    }
    @IBAction func btnSex(_ sender: UIButton) {
        sexDrop.show()
    }
    @IBAction func btnCity(_ sender: UIButton) {
        cityDrop.show()
    }
    
    @IBOutlet weak var btnGame: UIButton!
    @IBOutlet weak var btnRank: UIButton!
    @IBOutlet weak var btnSex: UIButton!
    @IBOutlet weak var btnCity: UIButton!

    
    @IBOutlet weak var dropDownGame: UIView!
    @IBOutlet weak var dropDownRank: UIView!
    @IBOutlet weak var dropDownSex: UIView!
    @IBOutlet weak var dropDownCity: UIView!
    
    
    @IBOutlet weak var gameTxt: UITextField!
    @IBOutlet weak var rankTxt: UITextField!
    @IBOutlet weak var sexTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    
    
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var listView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listView.delegate = self
        self.listView.dataSource = self

        
        
        
        setGameDrop()
        setRankDrop()
        setSexDrop()
        setCityDrop()
        
        print("useremail\(useremail)")
        
        dropDownGame.layer.cornerRadius = 5.0
        dropDownSex.layer.cornerRadius = 5.0
        dropDownCity.layer.cornerRadius = 5.0
        dropDownRank.layer.cornerRadius = 5.0
        btnSearch.layer.cornerRadius = 5
        
        // Background
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "redBackground")?.draw(in: self.view.bounds)
        
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
        gameDrop.anchorView = dropDownGame // UIView or UIBarButtonItem
        
        // The list of items to display. Can be changed dynamically
        gameDrop.dataSource = ["AoV", "PUBG", "Hearthstone"]
        
        //        DropDown.startListeningToKeyboard()
        gameDrop.selectionAction = { [weak self] (index, item) in
            self?.btnGame.setTitle(item, for: .normal)
        }
    }
    
    func setRankDrop(){
        rankDrop.anchorView = dropDownRank
        rankDrop.dataSource = ["1", "2", "3", "4", "5"]
        //        DropDown.startListeningToKeyboard()
        rankDrop.selectionAction = { [weak self] (index, item) in
            self?.btnRank.setTitle(item, for: .normal)
        }
    }
    
    func setSexDrop(){
        sexDrop.anchorView = dropDownSex
        sexDrop.dataSource = ["Male","Female"]
        //        DropDown.startListeningToKeyboard()
        sexDrop.selectionAction = { [weak self] (index, item) in
            self?.btnSex.setTitle(item, for: .normal)
        }
    }
    
    func setCityDrop(){
        cityDrop.anchorView = dropDownCity
        cityDrop.dataSource = ["NY","Boston","LA"]
        //        DropDown.startListeningToKeyboard()
        cityDrop.selectionAction = { [weak self] (index, item) in
            self?.btnCity.setTitle(item, for: .normal)
        }
    }
    
    
    
    
    
    @IBAction func searchAction(_ sender: Any) {
        var gamename = btnGame.titleLabel!.text
        var rank = btnRank.titleLabel!.text
        var sex = btnSex.titleLabel!.text
        var city = btnCity.titleLabel!.text
        
        let alert = UIAlertController(title: "Alert", message: "Please select each fields", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil))
        
        
//        guard gamename != "Game:" && rank != "Rank:" && sex != "Sex:" && city != "City:" else{self.present(alert, animated: true, completion: nil);return}
        
        let home2 = HomeModel2()
        home2.delegate = self
        print("useremail:\(useremail)")
        home2.downloadItemssearch(useremail: useremail, sex: sex!, gamename: gamename!, city: city!, rank: rank!)
        //home2.downloadItemssearch(useremail: "yu.zix@husky.neu.edu", sex: "man", gamename: "a", city: "LA", rank: "c")
    }
    
    
    //show table-start
    func itemDownloaded2(items: NSArray) {
        print("itemssearch\(items)")
        gameItems = items
        self.listView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return gameItems.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "searchgame"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the location to be shown
        let item: GameModel = gameItems[indexPath.row] as! GameModel
        // Get references to labels of cell
        myCell.textLabel?.text = "Game:\(item.gamename!) \nUser ID:\(item.userid!)  \nRank:\(item.rank!) "
        myCell.textLabel?.numberOfLines = 0
        myCell.textLabel?.font = UIFont (name: "AmericanTypewriter-Bold", size: 28)
        return myCell
    }
    //show table-end

}
