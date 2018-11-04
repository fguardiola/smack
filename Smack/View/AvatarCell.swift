//
//  AvatarCell.swift
//  Smack
//
//  Created by 67621177 on 04/11/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setView()
    }
    
    func setView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}
