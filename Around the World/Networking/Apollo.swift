//
//  Apollo.swift
//  Around the World
//
//  Created by Madison Yost on 3/27/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation
import Apollo
import Combine

let apollo: ApolloClient = {
    let client = ApolloClient(url: URL(string: "https://countries.trevorblades.com/")!)
    return client
}()

final class ApolloWrapper {

    func fetch<Query: GraphQLQuery>(query: Query) -> AnyPublisher <Data, Error> {
        return Future <Data, Error> { promise in
            apollo.fetch(query: query) { result in
                switch result {
                case .success(let result):
                    if let data = result.data {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: data.jsonObject, options: .fragmentsAllowed)
                            promise(Result.success(jsonData))
                        } catch {
                            print("Error converting result to json with error \(error)")
                            return promise(Result.failure(error))
                        }
                    } else if let errors = result.errors {
                        let message = errors
                            .map { $0.localizedDescription }
                            .joined(separator: "\n")
                        print( "GraphQL Error(s): \(message)")
                    }
                case .failure(let error):
                    return promise(Result.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
