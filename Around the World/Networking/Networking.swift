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

protocol QueryProviding {
    var network: Networking { get }

    func fetchContinents(_ completion: @escaping(Result<[Continent], Error>) -> Void)
    func fetchCountry(code: String, _ completion: @escaping(Result<Country, Error>) -> Void)
}

extension QueryProviding {
    func fetchContinents(_ completion: @escaping(Result<[Continent], Error>) -> Void) {
        network.fetch(ContinentsQuery(), completion: completion)
    }

    func fetchCountry(code: String, _ completion: @escaping(Result<Country, Error>) -> Void) {
        network.fetch(CountryQuery(code: code), completion: completion)
    }
}

protocol Networking {
    func fetch<T: Decodable>(_ request: RequestProviding, completion: @escaping(Result<T, Error>) -> Void)
}

extension Networking {
    func fetch<T: Decodable>(_ request: RequestProviding, completion: @escaping(Result<T, Error>) -> Void) {
        let urlRequest = request.urlRequest

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else { preconditionFailure("No error was received but there is no data...") }

                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
