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
    
    public typealias SectionSupplementaryViewProvider = (UICollectionView, String, IndexPath, S) -> UICollectionReusableView?
    
    private let scheduler: SchedulerContext
    
    private let retryIntent: PassthroughSubject<LoadingItem, Never>
    
    private var bag = Set<AnyCancellable>()
    
    public let loadPage = CurrentValueSubject<Bool, Never>(false)
    
    public convenience init(collectionView: UICollectionView,
                            scheduler: SchedulerContext,
                            itemCellProvider: @escaping UICollectionViewDiffableDataSource<S, I>.CellProvider,
                            supplementaryViewProvider: @escaping SectionSupplementaryViewProvider) {
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
                  },
                  supplementaryViewProvider: supplementaryViewProvider)
    }
    
    init(collectionView: UICollectionView,
         scheduler: SchedulerContext,
         retryIntent: PassthroughSubject<LoadingItem, Never>,
         cellProvider: @escaping UICollectionViewDiffableDataSource<SectionHolder<S>, ItemHolder<I>>.CellProvider,
         supplementaryViewProvider: @escaping SectionSupplementaryViewProvider) {
        
        self.retryIntent = retryIntent
        self.scheduler = scheduler
        
        collectionView.registerCell(for: LoadingCollectionCell.self)
        
        super.init(collectionView: collectionView, cellProvider: cellProvider)
        
        self.supplementaryViewProvider = { [unowned self] (collectionView, kind, indexPath) -> UICollectionReusableView? in
            
            let section = self.snapshot().sectionIdentifiers[indexPath.section]
            
            switch section {
            case .loading:
                return nil
            case .sections(let s):
                return supplementaryViewProvider(collectionView, kind, indexPath, s)
            }
        }
        
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
    
    public func item(at indexPath: IndexPath) -> I? {
        let item = itemIdentifier(for: indexPath)
        switch item {
        case .items(let i):
            return i
        default:
            return nil
        }
        
    }
}

// MARK: UICollectionViewCompositionalLayout + SectionProvider

extension DiffableDatasource {
    
    func sectionLayout(for sectionIndex: Int,
                       environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let section = snapshot().sectionIdentifiers[sectionIndex]
        
        switch section {
        case .loading: // full screen loading cell
            return LoadingCollectionCell.loadingSectionLayout
        case .sections(let section):
            return section.layout(environment: environment)
        }
    }
}
