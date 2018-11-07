//
//  ChatVC.swift
//  Smack
//
//  Created by 67621177 on 31/10/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import UIKit

class ChatVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var sendButton: UIButton!
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    
    // Variables
    var isTyping = false
    override func viewDidLoad() {
        super.viewDidLoad()
        //hidden at first
        sendButton.isHidden = true
        //tableview
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        //Socket listener
        SocketService.instance.getChatMessage { (success) in
            if success{
                self.tableView.reloadData()
                //scroll to bottom in case there are multiples messages
                let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
            }
        }
        
        //lift view when clicking on textfield
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap(_:)))
        view.addGestureRecognizer(tap)
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
    // MARK: - Tableview methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messages = MessageService.instance.messages
        //create cell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell{
            cell.configCell(message: messages[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
   
    //gesture recognizer handler
    @objc func handleTap(_ recognizer: UITapGestureRecognizer){
        //dismiss keboard
        view.endEditing(true)
    }
    @objc func userDidChange(_ notification: Notification){
        if AuthService.instance.isLoggedIn{
            //get the channels. This notification is coming after login in\
            self.onLoginGetMessages()
        }else {
           // change title label and show login
            channelNameLbl.text = "Please Log In"
            //w'll get a notification when we logout. We have Cleared the messages. Reload table to reflect it
            tableView.reloadData()
           
            
            
        }
    }
    @objc func channelSelected(_ notif: Notification){
        //update view
        self.updateWithChannel()
    }
    
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"
        self.getMessages()

    }
    
    // MARK: -  Actions
    @IBAction func messageTextEditing(_ sender: Any) {
        if messageTxt.text == ""{
            isTyping = false
            sendButton.isHidden = true
        }else{
            if isTyping == false {
                //first letter typed
                sendButton.isHidden = false
            }
            
            isTyping = true
        }
    }
    @IBAction func sendBtnPressed(_ sender: Any) {
        //send actual message if user is logged in & there is some txt
        if AuthService.instance.isLoggedIn{
            let user = UserDataService.instance
            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
            guard let messageBody = messageTxt.text else { return }
            SocketService.instance.addMessage(messageBody: messageBody, userId: user.id, channelId: channelId) { (success) in
                if(success){
                     print("Message Sent!!")
                    //reset text field & dismss keyboard
                    self.messageTxt.text = ""
                    self.messageTxt.resignFirstResponder()
                }
               
            }
        }
    }
    func onLoginGetMessages(){
        MessageService.instance.findAllChannels { (success) in
            if success{
                // we could get messages here
                //do stuff with channels
                //we can check here if we have channels and if so get messages for that channel
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    //WE HAVE TO UPDATE LABEL. NEW CHANNEL SELECTED. Do the sam than channelSelected
                    self.updateWithChannel()
                }
            }else{
                //what about error handling
                 self.channelNameLbl.text = "No channels yet"
            }
        }
    }
    
    func getMessages(){
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            //Do something with messges
            if success {
                print(MessageService.instance.messages)
                self.tableView.reloadData()
            }else{
                print("No messages")
            }
        }
    }

}
