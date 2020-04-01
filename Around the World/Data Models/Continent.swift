//
//  Continent.swift
//  Around the World
//
//  Created by Madison Yost on 3/26/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation

struct Continent: Codable, Identifiable {
    var id: String
    var name: String
    var countries: [Country]
}

extension Continent {
    enum CodingKeys: String, CodingKey  {
        case id = "code"
        case name
        case countries
    }
}


struct ContinentContainer: Codable {
    var continents: [Continent]?
}
