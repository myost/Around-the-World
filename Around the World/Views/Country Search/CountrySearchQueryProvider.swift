//
//  CountrySearchQueryProvider.swift
//  Around the World
//
//  Created by Madison Yost on 4/28/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation
import Combine

struct CountrySearchQueryProvider: CountryQueryProviding {
    var apiSession: APISessionProviding = ApiSession.shared

    func fetchCountries(code: String) -> AnyPublisher<[Country], Error> {
        return apiSession.execute(CountrySearchQuery(searchString: code))
        .decode(type: CountryData.self, decoder: JSONDecoder())
        .compactMap { $0.data.countries }
        .eraseToAnyPublisher()
    }
}
