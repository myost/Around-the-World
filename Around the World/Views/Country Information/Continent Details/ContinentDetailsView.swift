//
//  ContinentDetailsView.swift
//  Around the World
//
//  Created by Madison Yost on 4/2/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import SwiftUI
import MapKit

struct ContinentDetailsView: View {
    let continent: ContinentDisplayable

    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            continentInfo
            List {
                Section(header: Text("Countries")
                    .font(.headline)
                    .padding(5.0)) {
                    ForEach(continent.countries) { country in
                        NavigationLink(destination: CountryDetailsView(viewModel: CountryDetailsViewModel(countryId: country.id ?? "US"), title: country.name)) {
                            CountryRow(country: country)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(continent.name), displayMode: .inline)
    }

    private var continentInfo: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            createDetailView(withTitle: "Continent Code:", details: continent.id)
            createDetailView(withTitle: "Number of Countries", details: "\(continent.numberOfCountries)")
        }.padding(15)
    }
}
