//
//  MessageCell.swift
//  Smack
//
//  Created by 67621177 on 07/11/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBodyLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userImg: RoundedImage!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    func configCell(message:Message){
        nameLbl.text = message.userName
        messageBodyLbl.text  = message.message
//        timeStampLbl.text = message.timeStamp
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        
    }
}
