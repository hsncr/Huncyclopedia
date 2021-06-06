//
//  Array+Utils.swift
//  CoreInterface
//
//  Created by hsncr on 10.03.2021.
//

import Foundation


public extension Array {
    
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
