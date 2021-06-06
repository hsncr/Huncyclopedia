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
    
    let scheduler: SchedulerContext = SchedulerContextProvider.provide()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureTitle(_ title: String) {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.text = title
        titleLabel.font = UIFont(name: "Copperplate-Bold", size: 18)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }
    
}
