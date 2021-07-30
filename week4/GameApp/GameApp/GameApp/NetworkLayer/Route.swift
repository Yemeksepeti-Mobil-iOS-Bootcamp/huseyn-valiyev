//
//  Route.swift
//  GameApp
//
//  Created by Huseyn Valiyev on 22.07.2021.
//

import Foundation

enum Route {
    static let baseURL = "https://api.rawg.io/api"
    
    case fetchGames
    case fetchGameById(Int)
    
    var description: String {
        switch self {
        case .fetchGames:
            return "/games"
        case .fetchGameById(let id):
            return "/games/\(id)"
        }
    }
    
}
