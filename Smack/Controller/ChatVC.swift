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
    
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add action to button
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        //add an observer for notifications to react when user info change
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        //Channel selected observer
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
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
//        MessageService.instance.findAllChannels { (sucess) in
//            
//        }
    }
    @objc func userDidChange(_ notification: Notification){
        if AuthService.instance.isLoggedIn{
            //get the channels. This notification is coming after login in\
           self.onLoginGetMessages()
        }else {
           // change title label and show login
            channelNameLbl.text = "Please Log In"
        }
    }
    @objc func channelSelected(_ notif: Notification){
        //update view
        self.updateWithChannel()
    }
    
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"

    }
    func onLoginGetMessages(){
        MessageService.instance.findAllChannels { (success) in
            if success{
                //do stuff with channels
            }
        }
    }

}
