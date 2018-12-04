//
//  DescViewController.swift
//  final
//
//  Created by James on 2018/12/4.
//  Copyright © 2018年 James. All rights reserved.
//

import UIKit

class DescViewController: UIViewController,HomeModelProtocol2,UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
   
   var DescItems : NSArray = NSArray()
    var profile = ProfileModel()
   
    @IBOutlet weak var listView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listView.delegate = self
        self.listView.dataSource = self
        let home2 = HomeModel2()
        home2.delegate = self
        home2.downloadItemsallDescription()
    }
    

    func itemDownloaded2(items: NSArray) {
        print("items\(items)")
        DescItems = items
       self.listView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DescItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "Desc"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the location to be shown
        let item: ProfileModel = DescItems[indexPath.row] as! ProfileModel
        // Get references to labels of cell
        myCell.textLabel?.text = "UserEmail\(item.useremail)  Description:\(item.desc)"
        
        return myCell
    }
    
}
































































