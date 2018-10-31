//
//  CreateAccountVC.swift
//  Smack
//
//  Created by 67621177 on 31/10/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func closeCreateBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    

}
