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
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var avatarImg: UIImageView!
    //variables
    var avatarName: String = "profileDefault"
    // RGB color
    var avatarColor:  String = "[0.5,0.5,0.5,1]"
    var bgColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != ""{
            avatarName = UserDataService.instance.avatarName
            avatarImg.image = UIImage(named: avatarName)
            if avatarName.contains("light") && bgColor == nil{
                //to see avatar if no color has been generated
                avatarImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    @IBAction func closeCreateBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    func setUpView(){
        spinner.isHidden = true
        //set placeholders and colors
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "usernme", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceholder])
         emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceholder])
         passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceholder])
        
        //add tap recogniser to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
    @IBAction func pickBGColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255))/255
        let g = CGFloat(arc4random_uniform(255))/255
        let b = CGFloat(arc4random_uniform(255))/255
        avatarColor = "[\(r),\(g),\(b),1]"
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        
        //update background color of avatar image
        UIView.animate(withDuration: 0.3){
          self.avatarImg.backgroundColor = self.bgColor
        }
    
        //avatarColor =
        
    }
    @IBAction func createAccountPressed(_ sender: Any) {
        //show spinner
        spinner.isHidden = false
        spinner.startAnimating()
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
                                
                                //broadcast notification
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
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
