
import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    //singleton \
    static var instance  = AuthService()
    
    var userdefaults = UserDefaults.standard
    //property to know if user is logged in. Property stored on user defaults
    
    //this variables will be persisted along app launches 
    var isLoggedIn: Bool{
        get{
            return userdefaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            //newvalue is whatever vslaue we set this var to be like isLoggedIn = true
            userdefaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken:String {
        get{
            return userdefaults.value(forKey: TOKEN_KEY) as! String
        }
        set{
            userdefaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get{
            return userdefaults.value(forKey: USER_EMAIL) as! String
        }
        set{
            userdefaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
      
        /*
         {
         "email": "j@j.com",
         "password": "123456"
         }
         */
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil{
                completion(true)
            }
            else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    func login(email: String,  password: String, completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
       
        
        /*
         {
         "email": "j@j.com",
         "password": "123456"
         }
         */
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            //Json parser
            //parse json as a dictionary
            /* if let json = response.result.value as? Dictionary<String,Any>{
             if let email = json["user"] as? String{
             self.userEmail = email
             }
             if let token = json["token"] as? String{
             self.authToken = token
             }
             self.isLoggedIn = true
             completion(true)
             */
            // with swiftyJson. It unwraps values automatically for ya
            if response.result.error == nil {
                guard let data = response.data else { return }
                let json = JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
}
