//
//  RoundedImage.swift
//  Smack
//
//  Created by 67621177 on 05/11/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import UIKit
@IBDesignable
class RoundedImage: UIImageView {

    override func awakeFromNib() {
        self.setView()
    }
    
    func setView(){
        // if you set cornerradius of a square half of its width, is gonna result a perfect circle
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setView()
    }
}
