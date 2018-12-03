//
//  ProfileViewController.swift
//  final
//
//  Created by James on 2018/12/1.
//  Copyright © 2018年 James. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,HomeModelProtocol,HomeModelProtocol2,UINavigationControllerDelegate ,UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var bodTxt: UITextField!
    @IBOutlet weak var sexTxt: UITextField!
    @IBOutlet weak var descTxt: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
  
    @IBOutlet weak var addgameBtn: UIButton!
    @IBOutlet weak var listView: UITableView!
    
    @IBOutlet weak var imageTxt: UITextField!
    
    @IBOutlet weak var gameLabel: UILabel!
    private var datePicker:UIDatePicker?
   
    var useremail  = ""
    var feedItems : NSArray = NSArray()
    var gameItems : NSArray = NSArray()
     var profile = ProfileModel()
    func itemDownloaded(items: NSArray) {
        feedItems = items
        for i in feedItems{
            let item: ProfileModel = i as! ProfileModel
          
         bodTxt.text = item.birthday
            sexTxt.text = item.sex
            descTxt.text = item.desc
            imageTxt.text = item.image
            if (item.image != nil)
            {imageView.image = readImg(item.image!)}
            userName.text = item.username
            cityTxt.text = item.city
        }
    }
    func itemDownloaded2(items: NSArray) {
        print("items\(items)")
        gameItems = items
      self.listView.reloadData()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listView.delegate = self
        self.listView.dataSource = self
       let homemodel = HomeModel()
       homemodel.delegate = self
        homemodel.downloadItems(useremail: useremail)
        let home2 = HomeModel2()
        home2.delegate = self
        home2.downloadItems(useremail: useremail)
        
        
        emailtxt.text = useremail
        datePickerSetup()
        
     if let sex = sexTxt.text,
        let city = cityTxt.text
     {
        addgameBtn.isEnabled = true
        }
        
    }
    
    
    //addgame-start
    @IBAction func AddgameAction(_ sender: Any) {

        let alert = UIAlertController(title: "Add Game", message: nil, preferredStyle: .alert)
        alert.addTextField{(gamename) in gamename.placeholder = "Enter GameName"
        }
        alert.addTextField{(mark) in mark.placeholder = "Enter Userid"
        }
        alert.addTextField{(model) in model.placeholder = "Enter Rank"
        }

        let action1 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let action2 = UIAlertAction(title: "Add", style: .default){
            (_)in
            guard let gamename = alert.textFields?.first?.text
                else{return}

            guard let userid = alert.textFields![1].text
                else{return}

            guard let rank = alert.textFields![2].text
                else{return}


            self.addgame(gamename: gamename, rank: rank, userid: userid, useremail: self.useremail)
            
            let g = GameModel(useremail: self.useremail, gamename: gamename, userid: userid, rank: rank)
           
             self.listView.reloadData()
            print(self.gameItems.count)
            let home2 = HomeModel2()
            home2.delegate = self
            home2.downloadItems(useremail: self.useremail)
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
        

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
    //addgame-end
    
    
    
    
    //cell show-start
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return gameItems.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "game"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the location to be shown
        let item: GameModel = gameItems[indexPath.row] as! GameModel
        // Get references to labels of cell
        myCell.textLabel?.text = "GameName:\(item.gamename!)    Userid:\(item.userid!)    Rank:\(item.rank!)"
        
        return myCell
    }
    
 
    
    //cell show end
    
    
    
    
    //datepicker-start
    func datePickerSetup() -> Void {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action:#selector( ProfileViewController.dateChanged(datePicker: )), for:  .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.viewTapped(gestureRecogizer:)))
        
        
        bodTxt.inputView = datePicker
    }
    @objc func dateChanged(datePicker:UIDatePicker){
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM/dd/yyyy"
        bodTxt.text = dateformatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    @objc func viewTapped(gestureRecogizer: UITapGestureRecognizer) -> Void {
        view.endEditing(true)
    }
    //datepicker-end
    
    //selectimage-start
    
    
    @IBAction func selectAction(_ sender: Any) {
        let imagecontroller = UIImagePickerController()
        imagecontroller.delegate  = self
        imagecontroller.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(imagecontroller, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    //selectimage-end
    
   //edit-start
    
    @IBAction func editAction(_ sender: Any) {
        bodTxt.isEnabled = true
        sexTxt.isEnabled = true
        descTxt.isEnabled = true
        imageTxt.isEnabled = true
        selectBtn.isEnabled = true
        updateBtn.isEnabled = true
        userName.isEnabled = true
        cityTxt.isEnabled = true
        
    }
    //edit-end
   
    
    //record -start
    @IBAction func updateAction(_ sender: Any) {
        
        var editbod = ""
        var editsex = ""
        var editdes = ""
        var editimage = ""
        var editusername = ""
        var editcity = ""
        editbod = bodTxt.text!
        editsex = sexTxt.text!
        editdes = descTxt.text!
        editimage = imageTxt.text!
        editusername = userName.text!
        editcity = cityTxt.text!
       //validate
        let alert = UIAlertController(title: "Alert", message: "Please check your typing", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if !editdes.isAlpha(ignoreDiacritics: true) { alert.show(); print("desc") ;return}
        // if !editmodel.isAlpha(ignoreDiacritics: true) { alert.show(); print("model");return}
        //if !editdate .isAlpha(ignoreDiacritics: true) { alert.show(); print("date");return}
        if !editimage .isAlpha(ignoreDiacritics: true) { alert.show(); print("name");return}
          if !editusername .isAlpha(ignoreDiacritics: true) { alert.show(); print("username");return}
        saveImg(editimage, imageView.image!)
        record(username: editusername, des:editdes, sex: editsex, useremail: useremail, image: editimage, city: editcity, birthday: editbod)
        bodTxt.isEnabled = false
        sexTxt.isEnabled = false
        descTxt.isEnabled = false
        imageTxt.isEnabled = false
        selectBtn.isEnabled = false
        updateBtn.isEnabled = false
        userName.isEnabled = false
        cityTxt.isEnabled = false
      
    }
   
    
    
    
    func record(username:String,des:String,sex:String,useremail:String,image:String,city:String,birthday:String)
    {
        let url = URL(string: "http://localhost:8080/webios/update.htm")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "username=\(username)&des=\(des)&sex=\(sex)&useremail=\(useremail)&birthday=\(birthday)&image=\(image)&city=\(city)"
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
    //record-end
    
    
}
public extension UIViewController {
    func saveImg(_ fileName: String, _ pickedImageProduct: UIImage){
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        // get your UIImage jpeg data representation and check if the destination file url already exists
        if let data = pickedImageProduct.jpegData(compressionQuality: 1.0),
            !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // writes the image data to disk
                try data.write(to: fileURL)
                print("file saved")
            } catch {
                print("error saving file:", error)
            }
        }
    }
    
    func readImg(_ fileName: String)-> UIImage?{
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileURL.path){
            //            img.image = UIImage(contentsOfFile: fileURL.path)
            return UIImage(contentsOfFile: fileURL.path)!
        }else{
            print("No Image")
        }
        return nil
    }
    
    
}
public extension String{
    func isAlpha(ignoreDiacritics: Bool = false) -> Bool {
        if ignoreDiacritics {
            return self.range(of: "[^a-zA-Z]", options: .regularExpression) == nil && self != ""
        }
        else {
            return self.isAlpha()
        }
    }
    func isAlphaNum(ignoreDiacritics: Bool = false) -> Bool {
        if ignoreDiacritics {
            return self.range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil && self != ""
        }
        else {
            return self.isAlpha()
        }
    }
}

public extension UIAlertController {
    func show() {
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}

 
    
    

    


