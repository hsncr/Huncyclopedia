//
//  Combine+Never.swift
//  CoreApp
//
//  Created by hsncr on 5.02.2021.
//

import Foundation
import Combine


public extension Publishers {
    
    struct Never<Output>: Publisher {
        
        public typealias Failure = Swift.Never
        
        let empty = Empty<Output, Failure>(completeImmediately: false)
        
        public init() {}
        
        public func receive<S: Subscriber>(subscriber: S) where Self.Failure == S.Failure, Output == S.Input {
            empty.receive(subscriber: subscriber)
        }
    }
}
