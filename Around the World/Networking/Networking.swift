//
//  Networking.swift
//  Around the World
//
//  Created by Madison Yost on 4/21/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation
import Combine

protocol RequestProviding {
    var urlRequest: URLRequest { get }
}

protocol ContinentsQueryProviding {
    var apiSession: APISessionProviding { get }

    func fetchContinents() -> AnyPublisher<[Continent], Error>
}

protocol CountryQueryProviding {
    var apiSession: APISessionProviding { get }

    func fetchCountries(code: String) -> AnyPublisher<[Country], Error>
}

//protocol CountriesQueryProviding {
//    var apiSession: APISessionProviding
//}

protocol APISessionProviding {
    func execute(_ requestProvider: RequestProviding) -> AnyPublisher<Data, Error>
}

struct ApiSession: APISessionProviding {
    static let shared = ApiSession()

    func execute(_ requestProvider: RequestProviding) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: requestProvider.urlRequest)
            .tryMap { data, response in
                if let response = response as? HTTPURLResponse {
                    let headerData = response.allHeaderFields
                    print(headerData)
                }
                return data
            }
            .eraseToAnyPublisher()
    }
}
