//
//  UIViewController+ActionSheet.swift
//  CoreUI
//
//  Created by hsncr on 1.12.2020.
//

import UIKit

public struct ActionItem {
    
    let title: String
    let style: UIAlertAction.Style
    let selected: Bool
    
    init(_ title: String,
         _ style: UIAlertAction.Style = .default,
         _ selected: Bool = false) {
        self.title = title
        self.style = style
        self.selected = selected
    }
    
}

extension UIViewController {
    
    public func showActionListSheet(on sourceView: UIView? = nil,
                                    _ title: String,
                                    _ message: String,
                                    cancelTitle: String = "cancel",
                                    options actionList: [ActionItem],
                                    _ actionHandler: @escaping ((Int) -> Void)) {
        
        view.endEditing(true)
        
        let alertController = UIAlertController.actionSheet(title: title,
                                                            message: message)
        
        for (index, item) in actionList.enumerated() {
            
            let action = UIAlertAction(title: item.title,
                                       style: item.style,
                                       handler: { _ in
                                        actionHandler(index)
                                       })
            
            alertController.addAction(action)
        }
        
        
        let cancelAction = UIAlertAction(title: cancelTitle,
                                         style: .cancel,
                                         handler: nil)
        
        alertController.addAction(cancelAction)
        
        if let view = sourceView {
            alertController.modalPresentationStyle = .popover
            alertController.popoverPresentationController?.sourceView = view
        } else {
            alertController.modalPresentationStyle = .overFullScreen
        }
        
        present(alertController, animated: true, completion: nil)
    }
}

