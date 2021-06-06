//
//  HomeViewController.swift
//  Huncyclopedia
//
//  Created by hsncr on 1.06.2021.
//

import UIKit

extension HomeViewController: StoryboardLoadable {
    
    public static var storyboard: UIStoryboard {
        UIStoryboard(name: "Home", bundle: Bundle(for: HomeViewController.self))
    }
}

final class HomeViewController: BaseViewController {
    
    let viewModel: HomeViewModel
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var datasource = DiffableDatasource<HomeSection, HomeItem>(collectionView: collectionView, scheduler: scheduler)
    { [unowned self] (collectionView, indexPath, item) -> UICollectionViewCell? in
        switch item {
        case .aura(let aura):
            let cell: AuraTypeCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setupView(with: aura, isSelected: aura == self.viewModel.selectedAuraType.value)
            return cell
        case .hunter(let hunter):
            let cell: HunterCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setupView(with: hunter)
            return cell
        }
    } supplementaryViewProvider: { [unowned self] (collectionView, kind, indexPath, section) -> UICollectionReusableView? in
        return self.supplementaryView(in: collectionView, kind: kind, at: indexPath, section: section)
    }
    
    public init?(coder: NSCoder, viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTitle("Hunter X Hunter")
        
        configureCollectionView()
        
        bindViewModel()
    }
    
    private func configureCollectionView() {
        collectionView.registerCell(for: HunterCollectionViewCell.self)
        collectionView.registerCell(for: AuraTypeCollectionViewCell.self)
        collectionView.register(for: TitleHeaderCollectionReusableView.self,
                                ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.delegate = self
    }
    
    private func bindViewModel() {
        datasource.loadPage
            .filter { $0 == true }
            .debounce(for: .seconds(3), scheduler: scheduler.state)
            .receive(on: scheduler.ui)
            .sink(receiveValue: { [unowned self] value in
                self.viewModel.load()
            })
            .store(in: &bag)
        
        viewModel.initialData
            .receive(on: scheduler.ui)
            .sink { [unowned self] data in
                self.populateInitialData(auras: data.0, hunters: data.1)
            }.store(in: &bag)
        
        viewModel.filteredData
            .receive(on: scheduler.ui)
            .sink { [unowned self] data in
                self.populateFilteredData(hunters: data)
            }.store(in: &bag)
    }
    
    private func populateInitialData(auras: [AuraType], hunters: [Hunter]) {
        var snapshot = datasource.snapshot()
        
        snapshot.deleteAllItems()
        
        snapshot.appendSections([.sections(.aura), .sections(.hunter)])
        
        let auraItems: [ItemHolder<HomeItem>] = auras.map { .items(.aura($0)) }
        let hunterItems: [ItemHolder<HomeItem>] = hunters.map { .items(.hunter($0)) }
        snapshot.appendItems(auraItems, toSection: .sections(.aura))
        snapshot.appendItems(hunterItems, toSection: .sections(.hunter))
        
        datasource.apply(snapshot)
    }
    
    private func populateFilteredData(hunters: [Hunter]) {
        var snapshot = datasource.snapshot()
        
        snapshot.deleteSections([.sections(.hunter)])
        
        snapshot.appendSections([.sections(.hunter)])
        if let selectedAura = self.viewModel.selectedAuraType.value {
            snapshot.reloadItems([.items(.aura(selectedAura))])
        }
        let hunterItems: [ItemHolder<HomeItem>] = hunters.map { .items(.hunter($0)) }
        snapshot.appendItems(hunterItems, toSection: .sections(.hunter))
        snapshot.reloadSections([.sections(.hunter)])
        
        datasource.apply(snapshot)
    }
    
    private func loadingFailed() {
        datasource.loadingFailed()
    }
    
    private func unselect(aura: AuraType) {
        var snapshot = datasource.snapshot()
        snapshot.reloadItems([.items(.aura(aura))])
        datasource.apply(snapshot)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let item = datasource.item(at: indexPath)
        
        switch item {
        case .aura(let aura):
            let previouslySelected = self.viewModel.selectedAuraType.value
            viewModel.select(aura: aura)
            
            if let unselected = previouslySelected {
                unselect(aura: unselected)
            }
        case .hunter(let hunter):
            viewModel.selectedHunter.send(hunter)
        case .none:
            break
        }
    }
    
    
}

// MARK: Supplementary View Provider
extension HomeViewController {
    
    func supplementaryView(in collection: UICollectionView,
                           kind: String,
                           at indexPath: IndexPath,
                           section: HomeSection) -> UICollectionReusableView? {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            return nil
        }
        
        switch section {
        case .aura:
            let headerView: TitleHeaderCollectionReusableView = collection.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
            headerView.headerTitleLabel.text = "Aura Types"
            return headerView
        case .hunter:
            let headerView: TitleHeaderCollectionReusableView = collection.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
            
            if let auraType = self.viewModel.selectedAuraType.value {
                headerView.headerTitleLabel.text = auraType.title
            } else {
                headerView.headerTitleLabel.text = "Hunters"
            }
            
            return headerView
        }
    }
}
