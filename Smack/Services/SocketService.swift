//
//  SocketService.swift
//  Smack
//
//  Created by 67621177 on 06/11/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()
    
    let manager:  SocketManager
    let socket: SocketIOClient
    
    override init() {
        self.manager = SocketManager(socketURL: URL(string: BASE_URL)!)
        self.socket = manager.defaultSocket
        super.init()
    }
    
    // MARK: - Functions to send recive mesages to/from server
    
    func establishConnection(){
        socket.connect()
    }
    
    func endConnction(){
        socket.disconnect()
    }
    // MARK: - Control messages and channels through sockets to be spread to all clients (emit, on)
    // send channel to server. Parameters coming from API code
    func addChannel(channelName:String, channelDescription: String , completion: @escaping CompletionHandler) {
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    // listen to channel additions. Place this function where you want to listen for the event
        // we are getting an array like [channel.name, channel.descriptin, channel.id]
    func getChannel(completion: @escaping CompletionHandler){
        socket.on("channelCreated") { (channelDataArray, ack) in
            let name = channelDataArray[0] as? String
            let description = channelDataArray[1] as? String
            let id = channelDataArray[2] as? String
            
            let newChannel =  Channel(channelTitle:name, channelDescription: description, id: id)
            
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func getChatMessage(completion: @escaping CompletionHandler){
        socket.on("messageCreated") { (dataArray, ack) in
            //parse data
            guard let msgBody = dataArray[0] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let timeStamp = dataArray[7] as? String else { return }
            
            let channelSelectedId = MessageService.instance.selectedChannel?.id
            
            if (channelSelectedId == channelId && AuthService.instance.isLoggedIn){
                //add message to selected channel
                    let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                    MessageService.instance.messages.append(newMessage)
                    completion(true)
                } else {
                    completion(false)
                }
                
            }
    }
    //closure is going to be clled with a dictionary
    func getTypingUsers(_ completion: @escaping (_ typingUsers:[String: String])-> Void){
        socket.on("userTypingUpdate") { (usersTypingArray, ack) in
            guard let typingUsers = usersTypingArray[0] as? [String:String] else { return }
            /*["userName":channelId,...]
             The dictionary coming from the server
             */
           completion(typingUsers)
            
        }
        
    }
    
}
