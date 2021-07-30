//
//  GameLandscapeCollectionViewCell.swift
//  GameApp
//
//  Created by Huseyn Valiyev on 20.07.2021.
//

import UIKit
import Kingfisher

class GameLandscapeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: GameLandscapeCollectionViewCell.self)
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gameRatingLabel: UILabel!
    @IBOutlet weak var gameReleaseDateLabel: UILabel!
    
    func setup(game: Game) {
        gameTitleLabel.text = game.name
        gameImageView.kf.setImage(with: game.imageURL)
        gameRatingLabel.text = game.formattedRating
        gameReleaseDateLabel.text = game.releaseDate
    }
    

}
