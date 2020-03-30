//
//  CountryListView.swift
//  Around the World
//
//  Created by Madison Yost on 3/26/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import SwiftUI

struct CountryListView: View {
    private var continents = [Continent]()


    mutating func loadContinentData() {
        Network.shared.apollo
          .fetch(query: ContinentsInfoQuery()) { result in
            switch result {
            case .success(let graphQLResult):
              // TODO
                print(graphQLResult)
                if let continentsData = graphQLResult.data?.jsonObject {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: continentsData, options: .fragmentsAllowed)
                        let decoder = JSONDecoder()
                        let continentsDecoded = try decoder.decode([Continent].self, from: jsonData)
                        DispatchQueue.main.async {
                            self.continents = continentsDecoded
                        }
                    } catch {
                        print(error)
                    }
                }

                if let errors = graphQLResult.errors {
                  let message = errors
                        .map { $0.localizedDescription }
                        .joined(separator: "\n")
                  print( "GraphQL Error(s): \(message)")
                }
            case .failure(let error):
                print("Failed to get data error: \(error)")
            }
        }
    }

    var body: some View {
        List(continents) { continent in
            CountryRow()
        }
        
    }
}

struct CountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListView()
    }
}
