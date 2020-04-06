//
//  View+Extensions.swift
//  Around the World
//
//  Created by Madison Yost on 4/2/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import SwiftUI

extension View {
    ///A helper function that allows us to return a type-erased view
    ///Code was taken from the CombineFeedback MVVM example at: https://github.com/V8tr/ModernMVVM
    func eraseToAnyView() -> AnyView { AnyView(self) }

    ///A helper function that creates a detail view with a title and the details about that title
    func createDetailView(withTitle title: String, details: String) -> some View {
        return HStack(alignment: .firstTextBaseline, spacing: 10) {
            Text(title)
                .font(.headline)
            Text(details)
                .font(.subheadline)
        }
        .eraseToAnyView()
    }
}
