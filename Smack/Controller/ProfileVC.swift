//
//  ProfileVC.swift
//  Smack
//
//  Created by 67621177 on 05/11/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    //Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        // Do any additional setup after loading the view.
    }

    func setUpView(){
        userEmail.text = UserDataService.instance.email
        userName.text = UserDataService.instance.name
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
    }
    @objc func handleTap(_ recognizer: UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logUserOut()
        //we can listen to this notification frm other iew controllers to update things
        // for exmple clear channels on channelVC
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
}
