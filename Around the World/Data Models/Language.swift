//
//  Language.swift
//  Around the World
//
//  Created by Madison Yost on 3/26/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation

struct Language: Codable {
    var name: String
    var id: String
    var native: String?
    var rtl: String?
}

extension Language {
    enum CodingKeys: String, CodingKey  {
        case name
        case id = "code"
        case native
        case rtl
    }
}
