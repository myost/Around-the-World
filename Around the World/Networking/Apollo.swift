//
//  Apollo.swift
//  Around the World
//
//  Created by Madison Yost on 3/27/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation
import Apollo

let apollo: ApolloClient = {
    let client = ApolloClient(url: URL(string: "https://countries.trevorblades.com/")!)
    return client
}()

final class ApolloWrapper<T: Decodable> {
    typealias ApolloCompletion<T> = (Result<T, NetworkError>) -> Void

    func fetch<Query: GraphQLQuery>(query: Query, completion: ApolloCompletion<T>?) {
        apollo.fetch(query: query) { result in
            switch result {
            case .success(let result):
                if let data = result.data {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data.jsonObject, options: .fragmentsAllowed)
                        let decoder = JSONDecoder()
                        let object = try decoder.decode(T.self, from: jsonData)
                        completion?(.success(object))
                    } catch {
                        print("Error decoding: \(T.self) with error \(error)")
                        completion?(.failure(NetworkError.error(error)))
                    }
                }
                if let errors = result.errors {
                    let message = errors
                        .map { $0.localizedDescription }
                        .joined(separator: "\n")
                    print( "GraphQL Error(s): \(message)")
                    return
                }
            case .failure(let error):
                completion?(.failure(NetworkError.error(error)))
            }
        }
    }
}

enum NetworkError: Swift.Error {
    case error(Error)
}

enum Result<T, Error: Swift.Error> {
    case success(T)
    case failure(Error)
}
