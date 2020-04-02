//
//  CountryListViewModel.swift
//  Around the World
//
//  Created by Madison Yost on 4/1/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation
import Combine

final class CountryListViewModel: ObservableObject {

    //MARK: - Properties

    @Published private(set) var state = State.idle


    //MARK: Private

    private var cancellableSet = Set<AnyCancellable>()

    private let input = PassthroughSubject<Event, Never>()


    //MARK: - Initialization

    init() {
        //initialize the state machine using the system operation when
        Publishers.system(
            initial: state,
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


    //MARK: - Data Fetching

extension CountryListViewModel {
    static func fetchContinentData() -> AnyPublisher<[Continent], Error> {
        let publisher = ApolloWrapper().fetch(query: ContinentsInfoQuery())
            .decode(type: ContinentContainer.self, decoder: JSONDecoder())
            .compactMap {
                $0.continents
            }.eraseToAnyPublisher()
        return publisher
    }
}


//MARK: - State Machine

extension CountryListViewModel {

    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            switch event {
            case .onAppear:
                return .loading
            default:
                return state
            }
        case .loading:
            switch event {
            case .onContinentsLoaded(let continents):
                return .loaded(continents)
            case .onFailedToLoadContinents(let error):
                return .error(error)
            default:
                return state
            }
        case .loaded:
            return state
        case .error:
            return state
        }
    }

    static func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in input }
    }

    static func whenLoading() -> Feedback<State, Event> {
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading = state else { return Empty().eraseToAnyPublisher() }

            return Self.fetchContinentData()
                .map(Event.onContinentsLoaded)
                .catch { Just(Event.onFailedToLoadContinents($0)) }
                .eraseToAnyPublisher()
        }
    }
}


//MARK: - Constants

extension CountryListViewModel {
    enum State {
        case idle
        case loading
        case loaded([Continent])
        case error(Error)
    }

    enum Event {
        case onAppear
        case onSelectCountry(Int)
        case onContinentsLoaded([Continent])
        case onFailedToLoadContinents(Error)
    }
}
