//
//  Loadable.swift
//  CoreInterface
//
//  Created by hsncr on 14.12.2020.
//

import UIKit

@available(iOS 13.0, tvOS 13.0, *)
public protocol StoryboardLoadable {
    
    static var identifier: String { get }
    
    static var storyboard: UIStoryboard { get }
    
    static func load<T: UIViewController>(creator: @escaping ((NSCoder) -> T?)) -> T
}

public extension StoryboardLoadable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static func load<T: UIViewController>(creator: @escaping ((NSCoder) -> T?)) -> T {
        storyboard.instantiateViewController(identifier: identifier,
                                             creator: creator)
    }
}
