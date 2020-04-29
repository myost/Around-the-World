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

    init(viewModel: CountryDetailsViewModel, title: String) {
        self.title = title
        self.viewModel = viewModel
        //Remove the extra separator lines from the table view
        UITableView.appearance().tableFooterView = UIView()
    }

    var body: some View {
        content
        .navigationBarTitle("\(title)", displayMode: .inline)
        .onAppear { self.viewModel.send(event: .onAppear) }
    }

    private var content: some View {
        switch viewModel.state {
        case .idle:
            return Color.clear.eraseToAnyView()
        case .loading:
            return Spinner(isAnimating: true, style: .large).eraseToAnyView()
        case .error(let error):
            print("Error: \(error)")
            return Text("\(error.localizedDescription)").eraseToAnyView()
        case .loaded(let country):
            return countryInfoView(with: country).eraseToAnyView()
            
        }
    }

    private func countryInfoView(with country: CountryDisplayable) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 20) {
                createDetailView(withTitle: "Country Code:", details: country.id)
                createDetailView(withTitle: "Continent:", details: country.continent)
                createDetailView(withTitle: "Languages:", details: country.languages)
                createDetailView(withTitle: "Flag:", details: country.emoji)
            }.padding(15)
            createStateList(with: country.states)

        }
    }

    private func createStateList(with states: [Province]) -> some View {
        return List {
            Section(header: Text("States")
                .font(.headline)
                .padding(5)) {
                ForEach(states, id: \.name) { state in
                    Text("\(state.name)")
                        .font(.body)
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
