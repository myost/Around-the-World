//
//  CountryRow.swift
//  Around the World
//
//  Created by Madison Yost on 3/27/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import SwiftUI

struct CountryRow: View {
    let country: Country

    var body: some View {
        content
    }

    private var content: some View {
        return Text(country.name)
            .font(.body)
            .padding(5.0)
    }
}
