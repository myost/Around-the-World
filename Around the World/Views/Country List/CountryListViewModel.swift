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

    //MARK: - Properties

    @Published var continentData: [Continent]


    //MARK: - Initialization

    init() {
        //TODO
    }


    //MARK: - Private

    private func fetchContinentData() -> AnyPublisher<[Continent], Error> {
        let publisher = ApolloWrapper().fetch(query: ContinentsInfoQuery())
            .decode(type: ContinentContainer.self, decoder: JSONDecoder())
            .compactMap {
                $0.continents
            }.eraseToAnyPublisher()
        return publisher
    }
}


//MARK: - Constants

extension CountryListViewModel {
    enum State {
        case idle
        case loading
        case loaded([Continent])
        case error(Error)
    }

    enum Event {
        case onAppear
        case onSelectCountry(Int)
        case onContinentsLoaded([Continent])
        case onFailedToLoadContinents(Error)
    }
}
