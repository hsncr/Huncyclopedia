//
//  LoadingCollectionCell.swift
//  CoreInterface
//
//  Created by hsncr on 1.03.2021.
//

import UIKit
import Combine

public class LoadingCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var retryButton: UIButton!
    
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
    private var data: LoadingItem? = nil
    
    var retryIntent: PassthroughSubject<LoadingItem, Never>?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        retryButton.addAction(UIAction(handler: { [unowned self] _ in
            
            guard let item = data, item.state == .failed else {
                return
            }
            
            self.retryTapped(for: item)
            
        }), for: .touchUpInside)
    }
    
    func configure(data: LoadingItem) {
        self.data = data
        loadingIndicatorView.startAnimating()
        
        if data.state == .failed {
            retryButton.isHidden = false
            loadingIndicatorView.isHidden = true
        } else {
            retryButton.isHidden = true
            loadingIndicatorView.isHidden = false
        }
    }
    
    private func retryTapped(for item: LoadingItem) {
        
        guard let intent = retryIntent else {
            return
        }
        
        intent.send(item)
    }
    
}

extension LoadingCollectionCell {
    
    static var loadingSectionLayout: NSCollectionLayoutSection {
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
    }
}
