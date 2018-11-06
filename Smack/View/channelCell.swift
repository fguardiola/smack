//
//  channelCell.swift
//  Smack
//
//  Created by 67621177 on 06/11/2018.
//  Copyright © 2018 67621177. All rights reserved.
//

import UIKit

class channelCell: UITableViewCell {
    //Outlets
    @IBOutlet weak var channelName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //change bacground
        if selected{
            self.layer .backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    func configureCell(channel: Channel){
        let title = channel.channelTitle ?? ""
        channelName.text = "#\(title)"
    }

}
