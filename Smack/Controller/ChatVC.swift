//
//  ChatVC.swift
//  Smack
//
//  Created by 67621177 on 31/10/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    //Outlets
    
    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add action to button
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        //first view. Get user info is user is logged in
        if AuthService.instance.isLoggedIn{
            AuthService.instance.findUserByEmail { (success) in
                if success {
                    //send notification
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                }
            }
        }
        MessageService.instance.findAllChannels { (sucess) in
            
        }
    }
    

}
