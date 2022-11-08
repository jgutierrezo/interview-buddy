//
//  QuestionAnswerCard.swift
//  interview-buddy
//
//  Created by Rodrigo Chavez on 2022-11-08.
//

import UIKit

@IBDesignable class QuestionAnswerCard: UIView {

    let cornerRadius = 30.0
    let offsetWidth = 1.0
    let offsetHeight = 1.0
    let offsetShadowOpacity = 5.0
    
    var color = UIColor.systemGray5
    
    override func layoutSubviews() {
        layer.cornerRadius = self.cornerRadius
        layer.shadowColor = self.color.cgColor
        layer.shadowOffset = CGSizeMake(self.offsetWidth, self.offsetHeight)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.cornerRadius).cgPath
        layer.shadowOpacity = Float(self.offsetShadowOpacity)
    }

}
