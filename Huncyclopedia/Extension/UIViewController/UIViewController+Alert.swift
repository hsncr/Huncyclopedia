//
//  UIViewController+Alert.swift
//  CoreUI
//
//  Created by hsncr on 1.12.2020.
//

import UIKit

extension UIViewController {
    
    public func showMessage(title: String,
                            message: String,
                            actionTitle: String = "OK",
                            completion: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController.alert(title: title,
                                                      message: message)
        
        alertController.addAction(title: actionTitle,
                                  style: .default,
                                  handler: completion)
        
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.sourceView = view
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func showCancellableMessage(title: String,
                                       message: String,
                                       cancelTitle: String = "cancel",
                                       actionTitle: String = "OK",
                                       completion: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController.alert(title: title,
                                                      message: message)
        
        alertController.addAction(title: actionTitle,
                                  style: .default,
                                  handler: completion)
        
        alertController.addAction(title: cancelTitle,
                                  style: .cancel,
                                  handler: nil)
        
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.sourceView = view
        
        present(alertController, animated: true, completion: nil)
    }
    
}

