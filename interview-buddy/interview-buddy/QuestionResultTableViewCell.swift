//
//  QuestionResultTableViewCell.swift
//  interview-buddy
//
//  Created by Rodrigo Chavez on 2022-12-02.
//

import UIKit

class QuestionResultTableViewCell: UITableViewCell {
    
    @IBOutlet var question: UILabel!
    @IBOutlet var img: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
