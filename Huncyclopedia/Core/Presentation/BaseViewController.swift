//
//  BaseViewController.swift
//  BasicCoordinator
//
//  Created by hsncr on 20.12.2020.
//

import UIKit
import Combine

open class BaseViewController: UIViewController {
    
    public var bag = Set<AnyCancellable>()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
