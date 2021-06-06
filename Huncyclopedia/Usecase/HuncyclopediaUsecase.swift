//
//  HuncyclopediaUsecase.swift
//  Huncyclopedia
//
//  Created by hsncr on 2.06.2021.
//

import Foundation
import Combine

public protocol HuncyclopediaUsecaseProtocol {
    
    func fetchHunters(by type: AuraType) -> AnyPublisher<[Hunter], Never>
    
    func fetchAll() -> AnyPublisher<([AuraType], [Hunter]), Never>
}

public class HuncyclopediaUsecase: HuncyclopediaUsecaseProtocol {
    
    let auras: [AuraType]
    let hunters: [Hunter]
    
    init(auras: [AuraType] = AuraType.allCases,
         hunters: [Hunter] = HunterDataSource.all) {
        self.auras = auras
        self.hunters = hunters
    }
    
    public func fetchHunters(by type: AuraType) -> AnyPublisher<[Hunter], Never> {
        Deferred {
            Future { promise in
                let filtered = self.hunters.filter { $0.aura == type }
                promise(.success(filtered))
            }
        }.eraseToAnyPublisher()
    }
    
    public func fetchAll() -> AnyPublisher<([AuraType], [Hunter]), Never> {
        Deferred {
            Future { promise in
                promise(.success((self.auras, self.hunters)))
            }
        }.eraseToAnyPublisher()
    }
}
