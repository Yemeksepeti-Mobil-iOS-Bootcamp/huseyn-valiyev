//
//  SliderCollectionViewCell.swift
//  GameApp
//
//  Created by Huseyn Valiyev on 20.07.2021.
//

import UIKit
import Kingfisher

class SliderCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: SliderCollectionViewCell.self)
    
    @IBOutlet weak var sliderImageView: UIImageView!
    
    func setup(game: Game) {
        sliderImageView.kf.setImage(with: game.imageURL)
    }

}
