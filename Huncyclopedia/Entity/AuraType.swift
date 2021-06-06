//
//  AuraType.swift
//  Huncyclopedia
//
//  Created by hsncr on 2.06.2021.
//

import Foundation
import UIKit

public enum AuraType: CaseIterable, Hashable {
    case enhancer
    case transmuter
    case emitter
    case conjurer
    case manipulator
    case specialist
    
    var title: String {
        switch self {
        case .enhancer:
            return "Enhancer"
        case .transmuter:
            return "Transmuter"
        case .emitter:
            return "Emitter"
        case .conjurer:
            return "Conjurer"
        case .manipulator:
            return "Manipulator"
        case .specialist:
            return "Specialist"
        }
    }
    
    var abbreviation: String {
        switch self {
        case .enhancer:
            return "強"
        case .transmuter:
            return "变"
        case .emitter:
            return "放"
        case .conjurer:
            return "具"
        case .manipulator:
            return "操"
        case .specialist:
            return "特"
        }
    }
    
    var color: UIColor {
        switch self {
        case .enhancer:
            return .systemGreen
        case .transmuter:
            return .systemPurple
        case .emitter:
            return .systemOrange
        case .conjurer:
            return .systemRed
        case .manipulator:
            return .systemGray4
        case .specialist:
            return .systemBlue
        }
    }
}
