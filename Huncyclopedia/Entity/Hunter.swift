//
//  Hunter.swift
//  Huncyclopedia
//
//  Created by hsncr on 2.06.2021.
//

import Foundation

public struct Hunter: Hashable {
    let id: UUID = UUID()
    let name: String
    let aura: AuraType
    let image: String
    let referenceURL: URL
}
