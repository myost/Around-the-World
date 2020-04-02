//
//  CountryListView.swift
//  Around the World
//
//  Created by Madison Yost on 3/26/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import SwiftUI
import Combine

struct CountryListView: View {
    @ObservedObject var viewModel: CountryListViewModel

    var body: some View {
        NavigationView {
            content
                .navigationBarTitle("Countries")
        }.onAppear { self.viewModel.send(event: .onAppear) }
    }

    private var content: some View {
        switch viewModel.state {
        case .idle:
            return Color.clear.eraseToAnyView()
        case .loading:
            return Spinner(isAnimating: true, style: .large).eraseToAnyView()
        case .error(let error):
            return Text(error.localizedDescription).eraseToAnyView()
        case .loaded(let continents):
            return list(of: continents).eraseToAnyView()
        }
    }

    private func list(of continents: [Continent]) -> some View {
        return List {
            ForEach(continents) { continent in
                Section(header: Text("\(continent.name)")) {
                    ForEach(continent.countries) { country in
                        CountryRow()
                    }
                }
            }
        }
    }

    private var spinner: some View {
        Spinner(isAnimating: true, style: .medium)
    }
}

struct CountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListView(viewModel: CountryListViewModel())
    }
}
