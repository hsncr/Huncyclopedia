//
//  HomeSections.swift
//  Huncyclopedia
//
//  Created by hsncr on 5.06.2021.
//

import UIKit

enum HomeSection {
    case aura
    case hunter
}


extension HomeSection: Sectionable {
    
    func layout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        switch self {
        case .aura:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0)))
            
            // Group
            let layoutGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(64),
                                                   heightDimension: .absolute(64)),
                subitem: item,
                count: 1)
            layoutGroup.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(12),
                                                                    top: .fixed(0),
                                                                    trailing: .fixed(12),
                                                                    bottom: .fixed(0))
            // Section Header
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(64.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                     alignment: .top)
            // Section
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            layoutSection.boundarySupplementaryItems = [header]
            layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 12,
                                                                  leading: 16,
                                                                  bottom: 12,
                                                                  trailing: 16)
            return layoutSection
        case .hunter:
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .estimated(256))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            
            var layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: itemSize,
                                                               subitems: [layoutItem])
            
            // Group
            if UIScreen.main.isPortrait == false {
                layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize,
                                                                 subitem: layoutItem,
                                                                 count: 2)
            }
            
            layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 8,
                                                                leading: 8,
                                                                bottom: 8,
                                                                trailing: 8)
            // Section Header
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .estimated(64.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                     alignment: .top)
            // Section
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.interGroupSpacing = 12
            layoutSection.boundarySupplementaryItems = [header]
            layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 12,
                                                                  leading: 8,
                                                                  bottom: 12,
                                                                  trailing: 8)
            
            return layoutSection
        }
    }
}
