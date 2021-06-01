//
//  UIViewController+Share.swift
//  CoreUI
//
//  Created by hsncr on 1.12.2020.
//

import UIKit

extension UIViewController {
    
    public func shareURL(source: UIView, _ text: String) {
        
        let activityViewController = UIActivityViewController(activityItems: [text],
                                                              applicationActivities: nil)
        
        activityViewController.modalPresentationStyle = .popover
        activityViewController.popoverPresentationController?.sourceView = source
        
        present(activityViewController,
                animated: true,
                completion: nil)
    }
}
