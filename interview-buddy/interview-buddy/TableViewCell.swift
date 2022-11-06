//
//  TableViewCell.swift
//  Project
//
//  Created by Moanisha V on 2022-11-01.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var subCategoryLabel: UILabel!
    @IBOutlet var difficultyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(with subCategory: SubCategory) {
        subCategoryLabel.text = subCategory.title
        difficultyLabel.text = subCategory.difficultyLevel
    }

}
