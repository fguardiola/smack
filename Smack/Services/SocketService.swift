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
    
}
