//
//  Categories.swift
//  Project
//
//  Created by Moanisha V on 2022-10-18.
//

import UIKit

struct Category {
    let title: String
    let image: UIImage
}

let categories: [Category] = [
    Category(title:"JavaScript", image:UIImage(named:"js")!),
    Category(title:"Java", image:UIImage(named:"java")!),
    Category(title:"Swift", image:UIImage(named:"swift")!)
]
