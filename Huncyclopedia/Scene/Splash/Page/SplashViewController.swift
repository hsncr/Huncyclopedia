//
//  SplashViewController.swift
//  BasicCoordinator
//
//  Created by hsncr on 21.12.2020.
//

import UIKit
import Combine


extension SplashViewController: StoryboardLoadable {
    
    public static var storyboard: UIStoryboard {
        UIStoryboard(name: "Splash",
                     bundle: Bundle(for: SplashViewController.self))
    }
}

final class SplashViewController: BaseViewController {
    
    let completedSubject = PassthroughSubject<Bool, Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true,
                                                     animated: false)
        
        nextPage()
            .subscribe(completedSubject)
            .store(in: &bag)
    }
    
    // do some work and publish an event
    private func nextPage() -> AnyPublisher<Bool, Never> {
        Just(true)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
