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
        VStack(alignment: .leading, spacing: 20.0) {
            continentInfo
            List {
                Section(header: Text("Countries")
                    .font(.system(size: 24))
                    .padding(5.0)) {
                    ForEach(continent.countries) { country in
                        NavigationLink(destination: CountryDetailsView(viewModel: CountryDetailsViewModel(countryId: country.id), title: country.name)) {
                            CountryRow(country: country)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(continent.name), displayMode: .inline)
    }

    private var continentInfo: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text("Name: \(continent.name)")
            Text("Code: \(continent.id)")
            Text("Total number of countries: \(continent.numberOfCountries)")
        }.padding(20)
    }
}
