//
//  LoginVC.swift
//  Smack
//
//  Created by 67621177 on 31/10/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var userEmailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccountPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
  
    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner .startAnimating()
        guard let email = userEmailTxt.text, userEmailTxt.text != "" else { return  }
        guard let pass = passwordTxt.text, passwordTxt.text != "" else { return }
        AuthService.instance.login(email: email, password: pass) { (success) in
            if(success){
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success{
                        //we have user info. Send notification for other views to update
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        //dismiss view & hide spinner
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
           
        }
    }
    
    func setUpView(){
        spinner.isHidden = true
        //set placeholders
        userEmailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceholder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceholder])
    }
    
}
