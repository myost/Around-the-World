//
//  ContinentListQueryProvider.swift
//  Around the World
//
//  Created by Madison Yost on 4/22/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation
import Combine

struct ContinentListQueryProvider: ContinentsQueryProviding {
    var apiSession: APISessionProviding = ApiSession.shared

    func fetchContinents() -> AnyPublisher<[Continent], Error> {
        return apiSession.execute(ContinentsQuery())
            .decode(type: ContinentData.self, decoder: JSONDecoder())
            .compactMap { $0.data.continents }
            .eraseToAnyPublisher()
    }
}
