//
//  Channel.swift
//  Smack
//
//  Created by 67621177 on 05/11/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import Foundation
/* response
 [
 {
 "_id": "5be07d34e14740002717146c",
 "description": "this is the random channel, talk about whatevs!",
 "name": "random",
 "__v": 0
 }
 ]
 */
struct Channel {
    public private(set) var channelTitle : String!
    public private(set) var channelDescription : String!
    public private(set) var id : String!
    
}
