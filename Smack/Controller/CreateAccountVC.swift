//
//  CreateAccountVC.swift
//  Smack
//
//  Created by 67621177 on 31/10/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var avatarImg: UIImageView!
    //variables
    var avatarName: String = "profileDefault"
    // RGB color
    var avatarColor:  String = "[0.5,0.5,0.5,1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != ""{
            avatarName = UserDataService.instance.avatarName
            avatarImg.image = UIImage(named: avatarName)
            debugPrint("Avatarname:",avatarName)
        }
    }
    @IBAction func closeCreateBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func piskBGColorPressed(_ sender: Any) {
    }
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let name = userNameTxt.text, userNameTxt.text != "" else{
            return
        }
        guard let email = emailTxt.text, emailTxt.text != "" else{
            return
        }
        guard let password = passTxt.text, passTxt.text != "" else{
            return
        }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if(success){
                print("User registered!!")
                AuthService.instance.login(email: email, password: password, completion: { (success) in
                    if (success){
                        print("Loggedin user!!", AuthService.instance.authToken)
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if(success){
                                //end of last step. Navigate back
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                
                            }
                        })
                    }
                })
            }else{
                print("Error registering user")
            }
        }
        
    }
    
}
