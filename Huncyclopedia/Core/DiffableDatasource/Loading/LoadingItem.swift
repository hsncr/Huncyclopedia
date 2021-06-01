//
//  LoadingItem.swift
//  CoreInterface
//
//  Created by hsncr on 13.05.2021.
//

import Foundation

public enum LoadingState: Hashable {
    case `default`, loading, loaded, failed, completed
}

public class LoadingItem: Hashable, Identifiable {
    
    public let id: UUID = UUID()
    
    public var state: LoadingState = .default
    
    public init(state: LoadingState) {
        self.state = state
    }
    
}

extension LoadingItem {
    
    public static func == (lhs: LoadingItem, rhs: LoadingItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
