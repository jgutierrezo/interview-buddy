//
//  CategorieTableViewCell.swift
//  interview-buddy
//
//  Created by Rodrigo Chavez on 2022-12-01.
//

import UIKit

class CategorieTableViewCell: UITableViewCell {
    
    @IBOutlet var name: UILabel!
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
