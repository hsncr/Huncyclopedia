//
//  SectionLayoutProvider.swift
//  CoreInterface
//
//  Created by hsncr on 13.05.2021.
//

import UIKit

public protocol SectionLayoutProvider {
    
    func layout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection?
    
}

//public protocol SectionSupplementaryViewProvider {
//    func supplementaryView(in collection: UICollectionView,
//                           kind: String,
//                           at indexPath: IndexPath) -> UICollectionReusableView?
//}
