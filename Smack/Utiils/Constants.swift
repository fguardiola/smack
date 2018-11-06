//
//  Constants.swift
//  Smack
//
//  Created by 67621177 on 31/10/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import Foundation
//defining a type. We are saying that the copletion handler is a closure(Function that can be passed around in code)
typealias CompletionHandler = (_ Success:Bool) ->()

// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

// Colors
let smackPurplePlaceholder = #colorLiteral(red: 0.3568627451, green: 0.6235294118, blue: 0.7960784314, alpha: 0.5)

//Notification constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDatChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("notifChannelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("notifChannelSelected")
// User defaults

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedin"
let USER_EMAIL = "userEmail"


//URL constants

let BASE_URL = "https://chattychatfg.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_ADD_USER = "\(BASE_URL)/user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)/user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)/channel"




//Headers
//headers for resquest. We need a Json object key:value array
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]


let BARER_HEADER = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]
