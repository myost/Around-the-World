//
//  ContinentListViewModel.swift
//  Around the World
//
//  Created by Madison Yost on 4/1/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation
import Combine

final class ContinentListViewModel: ObservableObject {

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


//MARK: - State Machine

extension ContinentListViewModel {

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
                var continentsDisplayable = [ContinentDisplayable]()
                continents.forEach { continent in
                    continentsDisplayable.append(ContinentDisplayable(continent: continent))
                }
                return .loaded(continentsDisplayable)
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

            return ContinentsAPI.fetchContinentData()
                .map(Event.onContinentsLoaded)
                .catch { Just(Event.onFailedToLoadContinents($0)) }
                .eraseToAnyPublisher()
        }
    }
}


//MARK: - Constants

extension ContinentListViewModel {
    enum State {
        case idle
        case loading
        case loaded([ContinentDisplayable])
        case error(Error)
    }

    enum Event {
        case onAppear
        case onSelectContinent(Int)
        case onContinentsLoaded([Continent])
        case onFailedToLoadContinents(Error)
    }
}


struct ContinentDisplayable: Identifiable {
    var id: String
    var name: String
    var countries: [Country]

    var numberOfCountries: Int {
        return countries.count
    }

    init(continent: Continent){
        self.id = continent.id
        self.name = continent.name
        self.countries = continent.countries ?? [Country]()
    }
}
