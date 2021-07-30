//
//  Game.swift
//  GameApp
//
//  Created by Huseyn Valiyev on 20.07.2021.
//

import Foundation

struct Game: Decodable {
    
    let id: Int?
    let name: String?
    let rating: Double?
    let releaseDate: String?
    let image: String?
    let metacritic: Int?
    let description: String?
    
    var imageURL: URL? {
        return URL(string: image ?? " ")
    }
    
    var formattedRating: String {
        return "Rating: \(rating ?? 0)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case rating
        case releaseDate = "released"
        case image = "background_image"
        case metacritic
        case description
    }
    
}
