//
//  CategoriesCollectionViewCell.swift
//  Project
//
//  Created by Moanisha V on 2022-10-18.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    
    func setup(with category: Category) {
        categoryImage?.image = category.image
        titleLabel?.text = category.title
    }
}
