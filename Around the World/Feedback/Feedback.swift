//
//  Feedback.swift
//  Around the World
//
//  Created by Madison Yost on 4/2/20.
//  Copyright © 2020 Madison Yost. All rights reserved.
//

import Foundation
import Combine

/// Feedback is a type that will produce a stream of events in response to state changes it acts as the extension point between code that
/// generates events and code that reduces events into new states. It is also part of the state machine that helps to implement the
/// MVVM pattern into the app based on the CombineFeedback pattern.
/// Code was taken from the CombineFeedback MVVM example at: https://github.com/V8tr/ModernMVVM

struct Feedback<State, Event> {
    let run: (AnyPublisher<State, Never>) -> AnyPublisher<Event, Never>
}

extension Feedback {
    init<Effect: Publisher>(effects: @escaping (State) -> Effect) where Effect.Output == Event, Effect.Failure == Never {
        self.run = { state -> AnyPublisher<Event, Never> in
            state
                .map { effects($0) }
                .switchToLatest()
                .eraseToAnyPublisher()
        }
    }
}
