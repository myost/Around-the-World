//
//  Country.swift
//  Around the World
//
//  Created by Madison Yost on 3/26/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation

struct Country: Codable, Identifiable {
    var id: String?
    var name: String
    var phone: String?
    var continent: Continent?
    var currency: String?
    var languages: [Language]?
    var emoji: String?
    var emojiU: String?
    var states: [Province]?
}

extension Country {
    enum CodingKeys: String, CodingKey {
        case id = "code"
        case name
        case phone
        case continent
        case currency
        case languages
        case emoji
        case emojiU
        case states
    }
}

struct CountryContainer: Codable {
    var country: Country
}

struct CountryData: Codable {
    var data: CountryContainer
}
