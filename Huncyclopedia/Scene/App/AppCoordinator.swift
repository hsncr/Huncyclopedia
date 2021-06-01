//
//  AppCoordinator.swift
//  BasicCoordinator
//
//  Created by hsncr on 21.12.2020.
//

import UIKit
import Combine

final class AppCoordinator: BaseCoordinator<Void> {
    
    let window: UIWindow
    
    init(presenting navigationController: NavigationControllerReleaseHandler, in window: UIWindow) {
        self.window = window
        super.init(presenting: navigationController)
    }
    
    override func start() -> AnyPublisher<Void, Never> {
        
        startSplash()
        
        return Publishers.Never()
            .eraseToAnyPublisher()
    }
    
    private func startSplash() {
        let coordinator = SplashCoordinator(presenting: NavigationController())
        setRoot(to: coordinator, into: window)
            .sink { [unowned self] _ in
                self.startTab()
            }.store(in: &bag)
    }
    
    private func startTab() {
        let coordinator = HomeCoordinator(presenting: NavigationController())
        setRoot(to: coordinator, into: window)
            .sink { [unowned self] _ in
                self.startSplash()
            }.store(in: &bag)
    }
}
