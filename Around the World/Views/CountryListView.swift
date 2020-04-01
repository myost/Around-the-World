//
//  CountryListView.swift
//  Around the World
//
//  Created by Madison Yost on 3/26/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import SwiftUI

struct CountryListView: View {
    var body: some View {
        List {
            CountryRow()
        }
    }
}

struct CountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListView()
    }
}
