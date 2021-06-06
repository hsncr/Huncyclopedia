//
//  HomeCoordinator.swift
//  Huncyclopedia
//
//  Created by hsncr on 1.06.2021.
//

import UIKit
import Combine

final class HomeCoordinator: BaseCoordinator<Void> {
    
    lazy var viewController: HomeViewController = {
        let viewModel = HomeViewModel(usecase: HuncyclopediaUsecase(),
                                      scheduler: SchedulerContextProvider.provide())
        return HomeViewController.load { coder in
            HomeViewController(coder: coder,
                               viewModel: viewModel)
        }
    }()
    
    override var source: UIViewController  {
        get {
            router.navigationController.viewControllers = [viewController]
            return router.navigationController
        }
        set {}
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        
        viewController.viewModel.selectedHunter
            .flatMap { [unowned self] hunter -> AnyPublisher<Void, Never> in
                let coordinator = SafariCoordinator(presenting: router.navigationController,
                                                    url: hunter.referenceURL)
                return self.present(to: coordinator)
            }.sink { _ in
                //
            }.store(in: &bag)
        
        return Publishers.Never()
            .eraseToAnyPublisher()
    }
}
