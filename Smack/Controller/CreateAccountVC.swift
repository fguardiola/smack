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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func closeCreateBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    
    @IBAction func piskBGColorPressed(_ sender: Any) {
    }
    @IBAction func createAccountPressed(_ sender: Any) {
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
                    }
                })
            }else{
                print("Error registering user")
            }
        }
        
    }
    
}
