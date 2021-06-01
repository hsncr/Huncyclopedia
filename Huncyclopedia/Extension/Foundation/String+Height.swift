//
//  String+Height.swift
//  CoreUI
//
//  Created by hsncr on 1.12.2020.
//

import UIKit

extension UILabel {
    
    public func textHeight(using width: CGFloat) -> CGFloat {
        
        guard let text = text else {
            return 0
        }
        
        return text.height(using: width,
                           font: font)
    }
    
    public func attributedTextHeight(using width: CGFloat) -> CGFloat {
        
        guard let attributedText = attributedText else {
            return 0
        }
        
        return attributedText.height(using: width)
    }
}

extension String {
    
    public func height(using width: CGFloat, font: UIFont) -> CGFloat {
        
        let maxSize = CGSize(width: width,
                             height: CGFloat.greatestFiniteMagnitude)
        
        let actualSize = self.boundingRect(with: maxSize,
                                           options: [.usesLineFragmentOrigin],
                                           attributes: [.font : font],
                                           context: nil)
        
        return actualSize.height
    }
}

extension NSAttributedString {
    
    public func height(using width: CGFloat) -> CGFloat {
        
        let maxSize = CGSize(width: width,
                             height: CGFloat.greatestFiniteMagnitude)
        
        let actualSize = boundingRect(with: maxSize,
                                      options: [.usesLineFragmentOrigin],
                                      context: nil)
        return actualSize.height
    }
}
