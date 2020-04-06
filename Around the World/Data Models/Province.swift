//
//  Province.swift
//  Around the World
//
//  Created by Madison Yost on 3/26/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation

struct Province: Codable {
    var name: String
    var id: String?
    var country: Country?
}

extension Province {
    enum CodingKeys: String, CodingKey  {
        case name
        case id = "code"
        case country
    }
}
