//
//  DiffableDatasource.swift
//  CoreInterface
//
//  Created by hsncr on 13.05.2021.
//

import UIKit
import Combine

public typealias Sectionable = Hashable&SectionLayoutProvider

public enum ItemHolder<I: Hashable>: Hashable {
    case loading(LoadingItem)
    case items(I)
}

public enum SectionHolder<S: Sectionable>: Hashable {
    case loading
    case sections(S)
}

final public class DiffableDatasource<S: Sectionable, I: Hashable>: UICollectionViewDiffableDataSource<SectionHolder<S>, ItemHolder<I>> {
    
    private let scheduler: SchedulerContext
    
    private let retryIntent: PassthroughSubject<LoadingItem, Never>
    
    private var bag = Set<AnyCancellable>()
    
    public let loadPage = CurrentValueSubject<Bool, Never>(false)
    
    public convenience init(collectionView: UICollectionView,
                            scheduler: SchedulerContext,
                            itemCellProvider: @escaping UICollectionViewDiffableDataSource<S, I>.CellProvider) {
        let retryIntent = PassthroughSubject<LoadingItem, Never>()
        
        self.init(collectionView: collectionView,
                  scheduler: scheduler,
                  retryIntent: retryIntent,
                  cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                    switch item {
                    case .loading(let loadingItem):
                        let cell: LoadingCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
                        cell.retryIntent = retryIntent
                        cell.configure(data: loadingItem)
                        return cell
                    case .items(let item):
                        return itemCellProvider(collectionView, indexPath, item)
                    }
                  })
    }
    
    init(collectionView: UICollectionView,
         scheduler: SchedulerContext,
         retryIntent: PassthroughSubject<LoadingItem, Never>,
         cellProvider: @escaping UICollectionViewDiffableDataSource<SectionHolder<S>, ItemHolder<I>>.CellProvider) {
        
        self.retryIntent = retryIntent
        self.scheduler = scheduler
        
        super.init(collectionView: collectionView, cellProvider: cellProvider)
        
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: sectionLayout)
        
        configureRetry()
        
        configureLoadingSection(state: .loading)
        
        loadPage.send(true)
    }
    
    private func configureRetry() {
        retryIntent
            .compactMap { [unowned self] item -> SectionHolder<S>? in
                let snapshot = self.snapshot()
                let section = snapshot.sectionIdentifier(containingItem: .loading(item))
                return section
            }
            .receive(on: scheduler.ui)
            .map { [unowned self] section -> Bool in
                switch section {
                case .loading:
                    return self.configureLoadingSection(state: .loading)
                case .sections:
                    return false
                }
            }
            .filter { $0 == true }
            .subscribe(loadPage)
            .store(in: &bag)
    }
    
    @discardableResult
    private func configureLoadingSection(state: LoadingState = .loading) -> Bool {
        
        var snapshot = self.snapshot()
        
        if snapshot.sectionIdentifiers.isEmpty && snapshot.indexOfSection(.loading) == nil {
            snapshot.appendSections([.loading])
            let loadingItem = LoadingItem(state: state)
            snapshot.appendItems([.loading(loadingItem)], toSection: .loading)
        } else if let item = snapshot.itemIdentifiers(inSection: .loading).first {
            switch item {
            case .loading(let loadingItem):
                loadingItem.state = state
            default:
                return false
            }
            
            snapshot.reloadItems([item])
        }
        
        apply(snapshot, animatingDifferences: true)
        
        return true
    }
    
    
    @discardableResult
    public func loadingFailed() -> Bool {
        configureLoadingSection(state: .failed)
    }
    
    // MARK: UICollectionViewCompositionalLayout + SectionProvider
    
    func sectionLayout(for sectionIndex: Int,
                       environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let section = snapshot().sectionIdentifiers[sectionIndex]
        
        switch section {
        case .loading: // full screen loading cell
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: itemSize,
                                                               subitems: [layoutItem])
            
            layoutGroup.contentInsets = NSDirectionalEdgeInsets(horizontal: 10,
                                                                vertical: 10)
            
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.interGroupSpacing = 10
            
            return layoutSection
        case .sections(let section):
            return section.layout(environment: environment)
        }
    }
    
}
