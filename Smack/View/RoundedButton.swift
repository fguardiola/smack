//
//  RoundedButton.swift
//  Smack
//
//  Created by 67621177 on 02/11/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var conerRadius: CGFloat = 3.0 {
        didSet{
            self.layer.cornerRadius = conerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    func setupView(){
        self.layer.cornerRadius = conerRadius
    }
}
