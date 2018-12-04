//
//  MatchViewController.swift
//  final
//
//  Created by James on 2018/12/3.
//  Copyright © 2018年 James. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController,HomeModelProtocol2,UINavigationControllerDelegate ,UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate{

    var gameItems : NSArray = NSArray()
    var useremail  = ""
    
    @IBOutlet weak var gameTxt: UITextField!
    @IBOutlet weak var rankTxt: UITextField!
    @IBOutlet weak var sexTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    
    
    @IBOutlet weak var listView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listView.delegate = self
        self.listView.dataSource = self

        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        var gamename = gameTxt.text
        var rank = rankTxt.text
        var sex = sexTxt.text
        var city = cityTxt.text
        
        
        let home2 = HomeModel2()
        home2.delegate = self
        //home2.downloadItemssearch(useremail: useremail, sex: sex!, gamename: gamename!, city: city!, rank: rank!)
        home2.downloadItemssearch(useremail: "yu.zix@husky.neu.edu", sex: "man", gamename: "a", city: "LA", rank: "c")
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
        myCell.textLabel?.text = "GameName:\(item.gamename!)    Userid:\(item.userid!)    Rank:\(item.rank!) "
        
        return myCell
    }
    //show table-end

}
