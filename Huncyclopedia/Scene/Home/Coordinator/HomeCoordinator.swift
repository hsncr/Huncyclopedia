//
//  HomeCoordinator.swift
//  Huncyclopedia
//
//  Created by hsncr on 1.06.2021.
//

import UIKit
import Combine

final class HomeCoordinator: BaseCoordinator<Void> {
    
    lazy var viewController = {
        return HomeViewController()
    }()
    
    override var source: UIViewController  {
        get {
            router.navigationController.viewControllers = [viewController]
            return router.navigationController
        }
        set {}
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        return Publishers.Never()
            .eraseToAnyPublisher()
    }
}
