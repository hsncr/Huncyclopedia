//
//  UIScreen+Util.swift
//  CoreInterface
//
//  Created by hsncr on 11.02.2021.
//

import UIKit

extension UIScreen {

    var isPortrait: Bool {
        return self.bounds.width < self.bounds.height
    }
}
