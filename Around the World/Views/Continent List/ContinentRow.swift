//
//  ContinentRow.swift
//  Around the World
//
//  Created by Madison Yost on 4/2/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import SwiftUI

struct ContinentRow: View {
    let continent: Continent

    var body: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text(continent.name)
                .font(.largeTitle)
            HStack(alignment: .firstTextBaseline, spacing: 20.0) {
                Text(continent.id)
                    .font(.headline)
                Text("\(continent.numberOfCountries) countries")
                    .font(.headline)
            }
        }.padding(20.0)
    }
}
