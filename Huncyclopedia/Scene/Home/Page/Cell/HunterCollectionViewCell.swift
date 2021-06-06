//
//  HunterCollectionViewCell.swift
//  Huncyclopedia
//
//  Created by hsncr on 5.06.2021.
//

import UIKit

class HunterCollectionViewCell: UICollectionViewCell {
    
    static var CORNER_RADIUS: CGFloat = 8.0

    @IBOutlet weak var hunterImageView: UIImageView!
    
    @IBOutlet weak var hunterLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowRadius = HunterCollectionViewCell.CORNER_RADIUS
        layer.shadowOpacity = 0.1
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: HunterCollectionViewCell.CORNER_RADIUS, height: HunterCollectionViewCell.CORNER_RADIUS)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let remaining = 2*HunterCollectionViewCell.CORNER_RADIUS
        let rect = CGRect(x: HunterCollectionViewCell.CORNER_RADIUS,
                          y: HunterCollectionViewCell.CORNER_RADIUS,
                          width: bounds.width - remaining,
                          height: bounds.height - remaining)
        layer.shadowPath = UIBezierPath(roundedRect: rect,
                                        cornerRadius: HunterCollectionViewCell.CORNER_RADIUS).cgPath
    }

    func setupView(with item: Hunter) {
        hunterImageView.image = UIImage(named: item.image)
        hunterLabel.text = item.name
    }
}
