//
//  OnboardingCollectionViewCell.swift
//  HomeworkWeek-3
//
//  Created by Huseyn Valiyev on 4.07.2021.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImageView: UIImageView!
    
    func configure(image: UIImage) {
        slideImageView.image = image
    }
}
