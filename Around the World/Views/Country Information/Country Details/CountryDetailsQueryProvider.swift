//
//  CountryDetailsQueryProvider.swift
//  Around the World
//
//  Created by Madison Yost on 4/22/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation
import Combine

struct CountryDetailsQueryProvider: CountryQueryProviding {
    var apiSession: APISessionProviding = ApiSession.shared

    func fetchCountries(code: String) -> AnyPublisher<[Country], Error> {
        return apiSession.execute(CountryQuery(code: code))
        .decode(type: CountryData.self, decoder: JSONDecoder())
        .compactMap { $0.data.country }
        .map { [$0] }
        .eraseToAnyPublisher()
    }
}
