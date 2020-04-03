//
//  CountryDetailsView.swift
//  Around the World
//
//  Created by Madison Yost on 3/27/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import SwiftUI

struct CountryDetailsView: View {
    @ObservedObject var viewModel: CountryDetailsViewModel
    let title: String

    var body: some View {
        content
        .navigationBarTitle("\(title)", displayMode: .inline)
    }

    private var content: some View {
        switch viewModel.state {
        case .idle:
            return Color.clear.eraseToAnyView()
        case .loading:
            return Spinner(isAnimating: true, style: .large).eraseToAnyView()
        case .error(let error):
            return Text(error.localizedDescription).eraseToAnyView()
        case .loaded(let country):
            return countryInfoView(with: country).eraseToAnyView()
            
        }
    }

    private func countryInfoView(with country: CountryDisplayable) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            createDetailView(withTitle: "Country Code:", details: country.id)
            createDetailView(withTitle: "Continent:", details: country.continent)
            createDetailView(withTitle: "Languages:", details: country.languages)
            createDetailView(withTitle: "Flag:", details: country.emoji)
            createStateList(with: country.states)

        }
    }

    private func createDetailView(withTitle title: String, details: String) -> some View {
        return HStack(alignment: .firstTextBaseline, spacing: 10) {
            Text(title)
                .font(.headline)
            Text(details)
                .font(.subheadline)
        }.eraseToAnyView()
    }

    private func createStateList(with states: [Province]) -> some View {
        return List {
            Section(header: Text("States")) {
                ForEach(states) { state in
                    Text("\(state.name)")
                        .font(.subheadline)
                        .padding(10)
                }
            }

        }
    }
}

struct CountryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailsView(viewModel: CountryDetailsViewModel(countryId: "US"), title: "United States")
    }
}
