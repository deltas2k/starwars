//
//  Starship.swift
//  starwarsAPI
//
//  Created by Matthew O'Connor on 10/3/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import Foundation

struct TopLevelDict: Decodable {
    let starships: [Starship]
}

struct Starship: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case model
        case costCredits = "cost_in_credits"
        case maxSpeed = "max_atmosphering_speed"
        case films
    }
    
    let name: String
    let model: String
    let costCredits: String
    let maxSpeed: String
    let films: [String]
}
