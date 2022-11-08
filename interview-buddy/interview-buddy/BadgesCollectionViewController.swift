//
//  BadgesCollectionViewController.swift
//  interview-buddy
//
//  Created by Rodrigo Chavez on 2022-11-08.
//

import UIKit

class BadgesCollectionViewController: UICollectionViewController {
    
    let dataSource = [
        [
            "title": "Swift",
            "image": "https://i.pinimg.com/originals/a6/eb/ce/a6ebce1b8e3444cd7a7ca3d844abfc55.png"
        ],
        [
            "title": "Java",
            "image": "https://www.clipartmax.com/png/full/58-585427_certificate-ribbons-ribbon-badge-vector-png.png"
        ],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BadgeCollectionViewCell
            cell.titleLabel.text = dataSource[indexPath.row]["title"]
        // Create URL
        let url = URL(string: dataSource[indexPath.row]["image"]!)!

            // Fetch Image Data
            if let data = try? Data(contentsOf: url) {
                // Create Image and Update Image View
                cell.badgeImage.image = UIImage(data: data)
            }
        return cell
    }

}
