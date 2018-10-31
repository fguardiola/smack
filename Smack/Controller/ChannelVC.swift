//
//  ChannelVC.swift
//  Smack
//
//  Created by 67621177 on 31/10/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    //outlets
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    //Ib action to perform a segue from createaccount to get here
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){
        
    }
}
