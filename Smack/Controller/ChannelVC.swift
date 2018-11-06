//
//  ChannelVC.swift
//  Smack
//
//  Created by 67621177 on 31/10/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //outlets
    
    @IBOutlet weak var userImg: RoundedImage!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        
        tableView.delegate = self
        tableView.dataSource = self
        // Add an observer to listen to usedata changes notifications
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        
        //listen to new channels through the socket
        SocketService.instance.getChannel { (success) in
            if success{
                //reload channel data
                self.tableView.reloadData()
            }
        }
    }
    // It can happen than when this view loads the notification didnt get here cause it wasn't instanciated so we wont see image and name 
    override func viewDidAppear(_ animated: Bool) {
        self.setUserData()
    }
   
    @objc func userDidChange(_ notif:Notification){
        //change UI if user is loggedIn
       self.setUserData()
    }
    
    @objc func channelsLoaded(_ notif:Notification){
        //Update when channels are loaded
        tableView.reloadData()
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
            //if user logs out reloading data would clear channels and this function is fired by tenotfication
            tableView.reloadData()
        }
    }
    @IBAction func addChannelPressed(_ sender: Any) {
        //Instanciate addChannelvc. We should only be able to add and see channels if we are logged in
        if AuthService.instance.isLoggedIn{
            let addChannelVC = AddChannelVC()
            addChannelVC.modalPresentationStyle = .custom
            present(addChannelVC, animated: true, completion: nil)
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
    
    //table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return our custom cell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? channelCell{
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel:channel)
            return cell
        }else {
            return UITableViewCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MessageService.instance.selectedChannel = MessageService.instance.channels[indexPath.row]
        //send notification channel selected
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        //slide out menu
        self.revealViewController()?.revealToggle(animated: true)
    }
}
