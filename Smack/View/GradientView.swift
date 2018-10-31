//
//  GradientView.swift
//  Smack
//
//  Created by 67621177 on 31/10/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import UIKit
@IBDesignable //This view able to render on storyboard


class GradientView: UIView {
    // be able to change the property on inspector
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.3631127477, green: 0.4045833051, blue: 0.8775706887, alpha: 1){
        didSet{
            self.setNeedsLayout() //Change the UIView on storyboard when property is changed on inspector
        }
    }
    
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1){
        didSet{
            self.setNeedsLayout() //Change the UIView on storyboard when property is changed on inspector
        }
    }
    
    override func layoutSubviews() {
        
        //this function is called when we invoe setNeedsLayout. Do the gradient
        // to define a gradient we need: Colors , start and end point (0,0) top left corner (1,1)bottom-right, size
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]//it can be more than two
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds //the size of the ui that subclasses from
        self.layer.insertSublayer(gradientLayer, at: 0)// insert gradient on viewbeing the firest layer
        
    }

}
