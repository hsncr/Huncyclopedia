//
//  AuraTypeCollectionViewCell.swift
//  Huncyclopedia
//
//  Created by hsncr on 5.06.2021.
//

import UIKit

class AuraTypeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var auraLabel: CircleLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupView(with item: AuraType, isSelected: Bool = false) {
        auraLabel.text = item.abbreviation
        auraLabel.backgroundColor = item.color
        auraLabel.borderWidth = isSelected ? 3: 0
    }

}
