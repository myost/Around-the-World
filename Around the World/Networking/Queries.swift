//
//  Queries.swift
//  Around the World
//
//  Created by Madison Yost on 4/22/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation

protocol Query: RequestProviding {
    var body: [String: Any] { get }
    var type: QueryType { get }
    var urlRequest: URLRequest { get }
}

extension Query {
    var urlRequest: URLRequest {
           var request: URLRequest
           request = URLRequest(url: URL(string: "https://countries.trevorblades.com/")!)
           request.httpMethod = "POST"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           if let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: []) {
               request.httpBody = jsonBody
           } else {
               print("Error serializing the body content")
           }
           return request
    }
}

enum QueryType {
    case continents
    case country(_ code: String)
}

struct ContinentsQuery: Query, RequestProviding {
    var body: [String: Any] = [:]
    var type: QueryType

    init() {
        self.type = .continents
        self.body.updateValue(QueryStrings.ContinentsInfo, forKey: JSONRequestKeys.queryKey)
    }
}

struct CountryQuery: Query, RequestProviding {
    var body: [String: Any] = [:]
    var type: QueryType

    init(code: String) {
        self.type = .country(code)
        self.body.updateValue(QueryStrings.CountryInfo, forKey: JSONRequestKeys.queryKey)
        self.body.updateValue(["code": code], forKey: JSONRequestKeys.variableKey)
    }
}

fileprivate enum JSONRequestKeys {
    static let queryKey = "query"
    static let variableKey = "variables"
    static let operationNameKey = "operationName"
}

fileprivate enum QueryStrings {
    static let ContinentsInfo = """
        query ContinentsInfo {
          continents {
            name
            code
            countries {
              ...CountryBasics
            }
          }
        }

        fragment CountryBasics on Country {
          name
          code
        }
        """

    static let CountryInfo = """
            query CountryInfo($code: ID!) {
              country(code: $code) {
                ...CountryDetails
              }
            }

            fragment CountryDetails on Country {
              code
              name
              phone
              currency
              emoji
              continent{
                name
                code
              }
              states {
                ...StateDetails
              }
              languages{
                ...LanguageDetails
              }
            }

            fragment LanguageDetails on Language {
              name
              native
              code
            }

            fragment StateDetails on State {
              name
              code
            }
            """
}
