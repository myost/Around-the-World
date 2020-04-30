//
//  SearchView.swift
//  Around the World
//
//  Created by Madison Yost on 4/27/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import SwiftUI
import Combine

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel

init(viewModel: SearchViewModel) {
self.viewModel = viewModel
//Remove the extra line separators from table view
UITableView.appearance().tableFooterView = UIView()
}

    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "magnifyingglass")
                            .padding()
                        TextField("Enter a country code", text: $viewModel.countryCode)
                        .padding()
                    }
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                    .padding(10)
                }
                countriesList
                Spacer()
            }
        .padding()
             .navigationBarTitle("Country Search")
        }
    }

    var countriesList: some View {
        switch viewModel.state {
        case .idle:
            return EmptyView().eraseToAnyView()
        case .loading:
            return Spinner(isAnimating: true, style: .medium).eraseToAnyView()
        case .loaded(let countryModels):
            //create a country list and return that
            return list(of: countryModels).eraseToAnyView()
        case .error(let error):
            return Text(error.localizedDescription).eraseToAnyView()
        }
    }

    func list(of countries: [CountryDisplayable]) -> some View {
        return List {
            ForEach(countries) { country in
                NavigationLink(destination: CountryDetailsView(viewModel: CountryDetailsViewModel(countryId: country.id), title: country.name)) {
                    self.countryRow(with: country)
                }
            }
        }
    }

    func countryRow(with country: CountryDisplayable) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(country.name)
                    .font(.title)
            }
            HStack(alignment: .center, spacing: 20) {
                Text(country.id)
                    .font(.body)
                Text(country.emoji)
            }
        }.padding()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}
