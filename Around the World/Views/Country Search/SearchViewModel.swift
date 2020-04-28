//
//  SearchViewModel.swift
//  Around the World
//
//  Created by Madison Yost on 4/28/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class SearchViewModel: ObservableObject {

    // MARK: - Properties

    @Published var countryCode = ""

    // MARK: Private

    @Published private(set) var state = State.idle

    private static let countrySearchQueryProvider = CountrySearchQueryProvider()

    private var cancellableSet = Set<AnyCancellable>()

    private var validCountryCodePublisher: AnyPublisher<Event, Never> {
        $countryCode
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map(Event.onSearchTextChanged)
            .eraseToAnyPublisher()
    }


    // MARK: - Initialization

    init() {
        Publishers.system(initial: state,
            reduce: Self.reduce,
            scheduler: RunLoop.main,
            feedbacks: [
                Self.userInput(input: validCountryCodePublisher),
                Self.whenLoading()
        ])
            .assign(to: \.state, on: self)
            .store(in: &cancellableSet)

    }

    deinit {
        cancellableSet.removeAll()
    }
}


// MARK: - State Machine

extension SearchViewModel {
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            switch event {
            case .onSearchTextChanged(let searchString):
                return .loading(searchString)
            default:
                return state
            }
        case .loaded:
            switch event {
            case .onSearchTextChanged(let searchString):
                return .loading(searchString)
            default:
                return state
            }
        case .loading:
            switch event {
            case .onCountriesLoaded(let countries):
                //do the processing and pass back loaded with the displayable country object whatever that is
                let displayableCountries = countries.map {
                    CountryDisplayable(country: $0)
                }
                return .loaded(displayableCountries)
            case .onLoadingFailed(let error):
                return .error(error)
            default:
                return state
            }
        case .error:
            switch event {
            case .onSearchTextChanged(let searchString):
                return .loading(searchString)
            default:
                return state
            }
        }
    }

    static func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in input }
    }

    static func whenLoading() -> Feedback<State, Event> {
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
        guard case .loading(let searchString) = state else { return Empty().eraseToAnyPublisher() }

            return countrySearchQueryProvider.fetchCountries(code: searchString.uppercased())
                .map(Event.onCountriesLoaded)
                .catch { Just(Event.onLoadingFailed($0)) }
                .eraseToAnyPublisher()
            
        }
    }

    enum State {
        case idle
        case loading(String)
        case loaded([CountryDisplayable])
        case error(Error)
    }

    enum Event {
        case onAppear
        case onCountriesLoaded([Country])
        case onLoadingFailed(Error)
        case onSearchTextChanged(String)
    }
}
