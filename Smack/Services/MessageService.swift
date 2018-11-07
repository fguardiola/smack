//
//  MessageService.swift
//  Smack
//
//  Created by 67621177 on 05/11/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class MessageService{
    static let instance = MessageService()
    
    var channels  = [Channel]()
    var selectedChannel: Channel?
    var messages = [Message]()
    
    //function to get all channels of specific user
    func findAllChannels(completion: @escaping CompletionHandler){
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BARER_HEADER).responseJSON { (response) in
            if response.result.error == nil{
                //decode channels & addthem to collection
                guard let data = response.data else { return }
                if let jsonArray = JSON(data: data).array{
                    for item in jsonArray{
                        //get data to create a channel object and append it to channels
                        let name =  item["name"].stringValue
                        let description = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name,channelDescription:description, id:id)
                        self.channels.append(channel)
                    }
                   //Spread we got channels
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }
            }else{
                completion(true)
                debugPrint(response.result.error as Any)
            }
        }
    }
    func findAllMessagesForChannel(channelId:String, completion: @escaping CompletionHandler){
        Alamofire.request("\(URL_GET_MESSAGES)/\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil{
                //clear messages
                self.clearMessages()
                guard let data = response.data else { return }
                if let jsonArray = JSON(data: data).array {
                        for item in jsonArray {
                            //get data to create a new message
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["_id"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            
                            let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                            self.messages.append(message)
                        }
                        print("Messages:\(self.messages)")
                        completion(true)
                   
                }else{
                    print("Something went wrong")
                }
                
            }else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
        
    }
    //we should clear channels when login out
    func clearChannels(){
        channels.removeAll()
    }
    func clearMessages(){
        messages.removeAll()
    }
}
