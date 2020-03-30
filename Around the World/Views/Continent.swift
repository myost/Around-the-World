//
//  Continent.swift
//  Around the World
//
//  Created by Madison Yost on 3/26/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation

struct Continent: Codable {
    var code: String
    var name: String
    var countries: [Country]
}
