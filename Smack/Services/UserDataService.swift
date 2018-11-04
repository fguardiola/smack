//
//  UserDataSrvice.swift
//  Smack
//
//  Created by 67621177 on 04/11/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import Foundation

class UserDataService {
    //singleton
    static let instance = UserDataService()
    //other files classes can read these properties but only this class can set the value
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
   
    
    //need a functin to be called fro authservice when we get data back
    
    func setUserData(id:String,color:String,avatarName:String,email:String,name:String){
        //set values
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
        
    }
    func setAvatarName(avatarName:String){
        self.avatarName = avatarName
    }
}
