//
//  NSRegularExpression+Util.swift
//  CoreUI
//
//  Created by hsncr on 1.12.2020.
//

import Foundation

extension NSRegularExpression {
    
    public convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
    
    public func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0,
                            length: string.utf16.count)
        return firstMatch(in: string,
                          options: [],
                          range: range) != nil
    }
    
    // MARK: Replacer function
    public func replaceMatches(in string: String,
                               using replacer: (NSTextCheckingResult) -> String?) -> String {
        let matches = self.matches(in: string,
                                   options: [],
                                   range: NSRange(location: 0, length: string.count))
        return matches.reversed().reduce(into: string) { (current, result) in
            let range = Range(result.range, in: current)!
            
            guard let replacement = replacer(result) else {
                return
            }
            
            current.replaceSubrange(range, with: replacement)
        }
    }
}
