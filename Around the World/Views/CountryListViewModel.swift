//
//  CountryListViewModel.swift
//  Around the World
//
//  Created by Madison Yost on 4/1/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation
import Combine

final class CountryListViewModel: ObservableObject {
    @Published var continentData: [Continent]

    func fetchContinentData() -> AnyPublisher<[Continent], Error> {
        let publisher = ApolloWrapper().fetch(query: ContinentsInfoQuery())
            .decode(type: ContinentContainer.self, decoder: JSONDecoder())
            .compactMap {
                $0.continents
            }.eraseToAnyPublisher()
        return publisher
    }
}
