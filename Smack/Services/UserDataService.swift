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
    /*This function will be used to convert the avatarcolor stored on data base with format of
     "[0.5,0.5,0.5,1]" to an actual color we can use
 */
    func returnUIColor(components: String) -> UIColor {
        let scanner = Scanner(string: components)
        // characters to skip
        let skipped = CharacterSet(charactersIn: "[], ")//skip brackets and white spaces
        let comma = CharacterSet(charactersIn: ",") // used to scan till comma character
        scanner.charactersToBeSkipped = skipped
        
        // create vars to store values from string
        var r,g,b,a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        //set a default color in case something go wrong
        let defaultColor = UIColor.lightGray
        
        //unwrap the values we need floats from the string components
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
        
        //get float values
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(bUnwrapped.doubleValue)
        let bfloat = CGFloat(gUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        let colorToReturn = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return colorToReturn
    }
    
    func logUserOut(){
        self.id = ""
        self.avatarColor = ""
        self.avatarName = ""
        self.email = ""
        self.name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.authToken = ""
        AuthService.instance.userEmail = ""
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
    }
}
