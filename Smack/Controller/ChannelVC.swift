//
//  ChannelVC.swift
//  Smack
//
//  Created by 67621177 on 31/10/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    //outlets
    
    @IBOutlet weak var userImg: RoundedImage!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        // Add an observer to listen to usedata changes notifications
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    // It can happen than when this view loads the notification didnt get here cause it wasn't instanciated so we wont see image and name 
    override func viewDidAppear(_ animated: Bool) {
        self.setUserData()
    }
   
    @objc func userDidChange(_ notif:Notification){
        //change UI if user is loggedIn
       self.setUserData()
    }
    func setUserData(){
        if AuthService.instance.isLoggedIn{
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named:UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        }else{
            loginBtn.setTitle("login", for: .normal)
            userImg.image = UIImage(named: "profileDefault")
            userImg.backgroundColor = UIColor.clear
        }
    }
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            //present modal with profile info
            //instanciate
            let profile = ProfileVC()
            //Set present as modal
            profile.modalPresentationStyle = .custom
            //pesent
            present(profile, animated: true, completion: nil)
        }else{
           performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    //Ib action to perform a segue from createaccount to get here
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){
        
    }
}
