//
//  UIButton+Background.swift
//  CoreUI
//
//  Created by hsncr on 1.12.2020.
//

import UIKit

extension UIButton {
    
    @IBInspectable var disabledBackgroundColor: UIColor? {
        
        get {
            return backgroundColor
        }
        
        set {
            
            guard let color = newValue else {
                setBackgroundImage(nil, for: .disabled)
                return
            }
            
            let colorImage = UIImage(color: color,
                                     size: CGSize(width: 1,
                                                  height: 1))
            
            setBackgroundImage(colorImage, for: .disabled)
        }
    }
    
    @IBInspectable var selectedBackgroundColor: UIColor? {
        get {
            return backgroundColor
        }
        
        set {
            
            guard let color = newValue else {
                setBackgroundImage(nil, for: .selected)
                return
            }
            
            let colorImage = UIImage(color: color,
                                     size: CGSize(width: 1,
                                                  height: 1))
            
            setBackgroundImage(colorImage, for: .selected)
            setBackgroundImage(colorImage, for: .highlighted)
        }
    }
    
}
