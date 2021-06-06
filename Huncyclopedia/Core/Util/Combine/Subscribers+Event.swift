//
//  Subscribers+Event.swift
//  CoreApp
//
//  Created by hsncr on 11.02.2021.
//

import Combine

/// An "either" type around the possible values
public extension Subscribers {
    enum Event<Value, Failure: Error> {
        case value(Value)
        case complete(Subscribers.Completion<Failure>)
    }
}

public extension Publisher {
    
    func sink(event: @escaping (Subscribers.Event<Output, Failure>) -> ()) -> AnyCancellable {
        return sink(
            receiveCompletion: { c in event(.complete(c)) },
            receiveValue: { v in event(.value(v)) }
        )
    }
    
    func subscribe(with demand: Subscribers.Demand,
                   event: @escaping (Subscribers.Event<Output, Failure>) -> ()) -> AnyCancellable {
        return subscribe(with: demand,
                         receiveCompletion: { c in event(.complete(c)) },
                         receiveValue: { v in
                            event(.value(v))
                         })
    }
    
    func subscribeOutput<S>(_ subject: S) -> AnyCancellable where S : Subject, Self.Failure == S.Failure, Self.Output == S.Output {
        return sink { _ in
            //
        } receiveValue: { value in
            subject.send(value)
        }

    }
}

extension Subscribers.Event: Equatable where Value: Equatable, Failure: Equatable {
    
}

public extension Subscribers.Event {
    
    var isComplete: Bool {
        switch self {
        case .complete: return true
        default: return false
        }
    }
}

public extension Sequence {
    
    func asEvents(completion: Subscribers.Completion<Never>? = nil) -> Array<Subscribers.Event<Element, Never>> {
        return asEvents(failure: Never.self, completion: completion)
    }

    func asEvents<Failure>(failure: Failure.Type,
                           completion: Subscribers.Completion<Failure>? = nil) -> Array<Subscribers.Event<Element, Failure>> {
        let values = map(Subscribers.Event<Element, Failure>.value)
        guard let completion = completion else { return values }
        return values + [Subscribers.Event<Element, Failure>.complete(completion)]
    }
}
