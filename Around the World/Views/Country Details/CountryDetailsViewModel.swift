//
//  CountryDetailsViewModel.swift
//  Around the World
//
//  Created by Madison Yost on 4/3/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation
import Combine

final class CountryDetailsViewModel: ObservableObject {

    //MARK: - Properties

    @Published private(set) var state: State

    //MARK: Private

    private var cancellableSet = Set<AnyCancellable>()
    private let input = PassthroughSubject<Event, Never>()


    //MARK: - Initialization

    init(countryId: String) {
        state = .idle(countryId)

        Publishers.system(
            initial: .idle(countryId),
            reduce: Self.reduce,
            scheduler: RunLoop.main,
            feedbacks: [
                Self.whenLoading(),
                Self.userInput(input: input.eraseToAnyPublisher())
        ])
        .assign(to: \.state, on: self)
        .store(in: &cancellableSet)
    }

    deinit {
        cancellableSet.removeAll()
    }

    /// A way of passing user input and lifecycle events, send the events into the feed loop for propogation
    func send(event: Event) {
        input.send(event)
    }
}


//MARK: - State Machine

extension CountryDetailsViewModel {

    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle(let code):
            switch event {
            case .onAppear:
                return .loading(code)
            default:
                return state
            }
        case .loading:
            switch event {
            case .onCountryLoaded(let country):
                let countryDisplayable = CountryDisplayable(country: country)
                return .loaded(countryDisplayable)
            case .onFailedToLoadCountry(let error):
                return .error(error)
            default:
                return state
            }
        case .loaded:
            return state
        case .error(let error):
            print("Error doing things: \(error.localizedDescription)")
            return state
        }
    }

    static func whenLoading() -> Feedback<State, Event> {
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading(let code) = state else { return Empty().eraseToAnyPublisher() }

            return ContinentsAPI.fetchCountryData(code: code)
                .map(Event.onCountryLoaded)
                .catch { Just(Event.onFailedToLoadCountry($0)) }
                .eraseToAnyPublisher()
        }
    }

    static func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback(run: { _ in
            return input
        })
    }
}


// MARK: - Constants

extension CountryDetailsViewModel {
    enum State {
        case idle(String)
        case loading(String)
        case loaded(CountryDisplayable)
        case error(Error)
    }

    enum Event {
        case onAppear
        case onCountryLoaded(Country)
        case onFailedToLoadCountry(Error)
    }
}


//MARK: - CountryDisplayable

struct CountryDisplayable {
    var id: String
    var name: String
    var phone: String
    var continent: String
    var currency: String
    var languages: String
    var emoji: String
    var emojiU: String
    var states: [Province]

    init(country: Country) {
        self.id = country.id ?? ""
        self.name = country.name
        self.phone = country.phone ?? ""
        self.continent = country.continent?.name ?? ""
        self.currency = country.currency ?? ""
        self.languages = country.languages?.compactMap { $0.name }.joined(separator: ", ") ?? ""
        self.emoji = country.emoji ?? ""
        self.emojiU = country.emojiU ?? ""
        self.states = country.states ?? [Province]()
    }
}
