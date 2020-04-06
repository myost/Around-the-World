//
//  ContinentsAPI.swift
//  Around the World
//
//  Created by Madison Yost on 4/3/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation
import Combine

///A static enum to hold the actual networking requests which are executed through the ApolloWrapper class
enum ContinentsAPI {

    ///A function for fetching basic data on all continents
    static func fetchContinentData() -> AnyPublisher<[Continent], Error> {
        return Deferred {
            ApolloWrapper().fetch(query: ContinentsInfoQuery())
            .decode(type: ContinentContainer.self, decoder: JSONDecoder())
            .compactMap { $0.continents }
            .eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }

    ///A function for getting all data on a specific country
    static func fetchCountryData(code: String) -> AnyPublisher<Country, Error>  {
        return Deferred {
            ApolloWrapper().fetch(query: CountryInfoQuery(code: code))
            .decode(type: CountryContainer.self, decoder: JSONDecoder())
            .compactMap { $0.country }
            .eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
}
