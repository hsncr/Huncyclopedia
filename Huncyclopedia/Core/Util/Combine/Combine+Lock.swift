//
//  Combine+Lock.swift
//  CombineTakeUntil
//
//  Created by hsncr on 20.01.2021.
//

import Foundation

extension NSRecursiveLock {
    
    // MARK: block is executed inside lock to provide syncronous execution
    @inlinable
    @inline(__always)
    func synchronize<T>(_ block: () throws -> T) rethrows -> T {
        lock()
        defer { unlock() }
        return try block()
    }
    
    // MARK: side effect is executed outside of lock to prevent deadlock
    @inlinable
    @inline(__always)
    func synchronized(_ block: (inout (() -> Void)?) -> Void)
    {
        var sideEffect: (() -> Void)?
        synchronize { block(&sideEffect) }
        sideEffect?()
    }
}

