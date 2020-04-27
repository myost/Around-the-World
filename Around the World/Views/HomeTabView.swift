//
//  TabView.swift
//  Around the World
//
//  Created by Madison Yost on 4/27/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        TabView {
            ContinentListView(viewModel: ContinentListViewModel())
            .tabItem {
                Image(systemName: "list.dash")
                Text("Countries")
            }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
            }
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
