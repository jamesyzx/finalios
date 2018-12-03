//
//  SignedViewController.swift
//  final
//
//  Created by James on 2018/11/30.
//  Copyright © 2018年 James. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignedViewController: UIViewController {

    @IBOutlet weak var emailtxt: UILabel!
    let userDefaults = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let email = Auth.auth().currentUser?.email else{return}
        emailtxt.text = email

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signout(_ sender: Any) {
        print("dwqdwqdwq")
        do{
            print("4")
            try Auth.auth().signOut()
           
            try GIDSignIn.sharedInstance()?.signOut()
            print("2")
            self.userDefaults.removeObject(forKey: "usersignedin")
            print("3")
            self.userDefaults.synchronize()
            self.dismiss(animated: true, completion: nil)
        }
        catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    @IBAction func searchAction(_ sender: Any) {
        var mc = storyboard?.instantiateViewController(withIdentifier: "MatchViewController") as? MatchViewController
       
        self.navigationController?.pushViewController(mc!, animated: true)
        
    }
    @IBAction func profileaction(_ sender: Any) {
        
        var pvc = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
       pvc?.useremail = emailtxt.text!
        self.navigationController?.pushViewController(pvc!, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
