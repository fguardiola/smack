//
//  AddChannelVC.swift
//  Smack
//
//  Created by 67621177 on 06/11/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    // Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        // Do any additional setup after loading the view.
    }

    @IBAction func addChannelPressed(_ sender: Any) {
    }
    
    @IBAction func closePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpView (){
        //set placeholders and colors testfields
        nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceholder])
        descriptionTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceholder])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        bgView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
}
