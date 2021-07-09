//
//  Slide.swift
//  HomeworkWeek-3
//
//  Created by Huseyn Valiyev on 4.07.2021.
//

import Foundation

struct Slide {
    let imageName: String
    let title: String
    let description: String
    
    static let collection: [Slide] = [
        Slide(imageName: "cheep", title: "Cheep", description: "You can find the cheapest products here."),
        Slide(imageName: "fast", title: "Fast", description: "Our products are delivered to you very quickly."),
        Slide(imageName: "tasty", title: "Tasty", description: "Dishes according to the taste of hundreds of people."),
    ]
}
