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


// User defaults

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedin"
let USER_EMAIL = "userEmail"


//URL constants

let BASE_URL = "https://chattychatfg.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"


//Headers
//headers for resquest. We need a Json object key:value array
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]
