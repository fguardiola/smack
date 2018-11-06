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
                   // print(self.channels[0].channelTitle)
                    completion(true)
                }
            }else{
                completion(true)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
