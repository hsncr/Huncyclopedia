//
//  ViewModel.swift
//  CoreInterface
//
//  Created by hsncr on 13.05.2021.
//

import Foundation
import Combine

open class ViewModel {
    
    public var bag = Set<AnyCancellable>()
    
    public let scheduler: SchedulerContext
    
    public init(scheduler: SchedulerContext) {
        self.scheduler = scheduler
    }
    
}
