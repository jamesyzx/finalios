//
//  ViewController.swift
//  final
//
//  Created by James on 2018/11/30.
//  Copyright © 2018年 James. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate{

    
    
    let userDefault = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
      
        GIDSignIn.sharedInstance().uiDelegate = self

        print("come baby")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if userDefault.bool(forKey: "usersignedin"){
            performSegue(withIdentifier: "signed", sender: self)
        }
    }
    
    


}

