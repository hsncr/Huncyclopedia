//
//  String+Attributed.swift
//  CoreUI
//
//  Created by hsncr on 1.12.2020.
//

import UIKit

// swiftlint:disable missing_docs
extension String {
    
    public var attributed: NSAttributedString {
        return NSMutableAttributedString(string: self)
    }
    
    public var bold: NSAttributedString {
        return NSMutableAttributedString(string: self,
                                         attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    public var underline: NSAttributedString {
        return NSAttributedString(string: self,
                                  attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    public var strikethrough: NSAttributedString {
        return NSAttributedString(string: self,
                                  attributes: [.strikethroughStyle:
                                                NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
    }
    
    public var italic: NSAttributedString {
        return NSMutableAttributedString(string: self,
                                         attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    public func colored(with color: UIColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
    }
    
}
