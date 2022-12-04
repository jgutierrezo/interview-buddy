//
//  BadgeTableViewCell2.swift
//  interview-buddy
//
//  Created by Juan David Gutierrez Ochoa on 2022-12-03.
//

import UIKit

class BadgeTableViewCell2: UITableViewCell {

    @IBOutlet var img: UIImageView!
    @IBOutlet var language: UILabel!
    @IBOutlet var level: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
