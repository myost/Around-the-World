//
//  System.swift
//  Around the World
//
//  Created by Madison Yost on 4/2/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Combine

/// System is an operator extension on Publishers that creates a feedback loop and bootstraps dependencies. It is also a part of
/// the state machine that helps to implement the MVVM pattern into the app based on the CombineFeedback pattern.
/// Code was taken from the CombineFeedback MVVM example at: https://github.com/V8tr/ModernMVVM

extension Publishers {

    static func system<State, Event, Scheduler: Combine.Scheduler>(
        initial: State,
        reduce: @escaping (State, Event) -> State,
        scheduler: Scheduler,
        feedbacks: [Feedback<State, Event>]
    ) -> AnyPublisher<State, Never> {

        let state = CurrentValueSubject<State, Never>(initial)

        let events = feedbacks.map { feedback in feedback.run(state.eraseToAnyPublisher()) }

        return Deferred {
            Publishers.MergeMany(events)
                .receive(on: scheduler)
                .scan(initial, reduce)
                .handleEvents(receiveOutput: state.send)
                .receive(on: scheduler)
                .prepend(initial)
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}
