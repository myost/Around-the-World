//
//  CountryListView.swift
//  Around the World
//
//  Created by Madison Yost on 3/26/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import SwiftUI

struct CountryListView: View {
    @ObservedObject var viewModel: CountryListViewModel

    var body: some View {
        List {
            CountryRow()
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
