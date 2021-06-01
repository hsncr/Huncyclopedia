//
//  XibView.swift
//  CoreUI
//
//  Created by hsncr on 1.12.2020.
//

import UIKit

public class XibView: UIView {
    
    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        xibSetup()
    }
    
    private func xibSetup() {
        backgroundColor = .clear
        
        view = loadXib()
        
        view.frame = bounds
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        NSLayoutConstraint.activate([topAnchor.constraint(equalTo: view.topAnchor),
                                     bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     rightAnchor.constraint(equalTo: view.rightAnchor),
                                     leftAnchor.constraint(equalTo: view.leftAnchor)])
    }
    
    private func loadXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let xibName = type(of: self).description().components(separatedBy: ".").last!
        let xib = UINib(nibName: xibName, bundle: bundle)
        return (xib.instantiate(withOwner: self, options: nil).first as? UIView)!
    }
}
