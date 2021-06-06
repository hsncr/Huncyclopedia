//
//  HomeViewModel.swift
//  Huncyclopedia
//
//  Created by hsncr on 5.06.2021.
//

import Foundation
import Combine

final class HomeViewModel: ViewModel {
    
    private let usecase: HuncyclopediaUsecaseProtocol
    
    let initialData = PassthroughSubject<([AuraType], [Hunter]), Never>()
    
    let filteredData = PassthroughSubject<[Hunter], Never>()
    
    let selectedAuraType = CurrentValueSubject<AuraType?, Never>(nil)
    
    let selectedHunter = PassthroughSubject<Hunter, Never>()
    
    private var cache: [Hunter] = []
    
    public init(usecase: HuncyclopediaUsecaseProtocol, scheduler: SchedulerContext) {
        self.usecase = usecase
        super.init(scheduler: scheduler)
    }
    
    func load() {
        usecase.fetchAll()
            .subscribe(on: scheduler.concurrent)
            .receive(on: scheduler.ui)
            .handleEvents(receiveOutput: {[unowned self] data in
                self.cache.append(contentsOf: data.1)
            })
            .subscribe(self.initialData)
            .store(in: &bag)
    }
    
    func select(aura: AuraType) {
        if self.selectedAuraType.value == aura {
            loadFilteredData(by: nil)
        } else {
            loadFilteredData(by: aura)
        }
        
    }
    
    private func loadFilteredData(by aura: AuraType?) {
        self.selectedAuraType.send(aura)
        
        guard let aura = aura else {
            Just(cache)
                .subscribe(on: scheduler.concurrent)
                .receive(on: scheduler.ui)
                .subscribeOutput(self.filteredData)
                .store(in: &bag)
            return
        }
        
        usecase.fetchHunters(by: aura)
            .subscribe(on: scheduler.concurrent)
            .receive(on: scheduler.ui)
            .subscribeOutput(self.filteredData)
            .store(in: &bag)
    }
    
}
