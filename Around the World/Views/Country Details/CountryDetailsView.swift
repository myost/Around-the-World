//
//  CountryDetailsView.swift
//  Around the World
//
//  Created by Madison Yost on 3/27/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import SwiftUI

struct CountryDetailsView: View {
    let country: Country

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Code: \(country.id)")
            VStack {
                Text("Languages Spoken:")
                ForEach(country.languages) { language in
                    Text("\(language.name)")
                }
            }
        }
        .navigationBarTitle("\(country.name)", displayMode: .inline)
    }
}

//struct CountryDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CountryDetailsView()
//    }
//}
