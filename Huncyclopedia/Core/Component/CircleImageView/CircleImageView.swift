//
//  CircleImageView.swift
//  CoreUI
//
//  Created by hsncr on 1.12.2020.
//

import UIKit

class CircleImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        clipsToBounds = true
        layer.cornerRadius = frame.size.height / 2
        
    }
}
