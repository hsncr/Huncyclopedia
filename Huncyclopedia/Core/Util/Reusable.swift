//
//  Reusable.swift
//  CoreUI
//
//  Created by hsncr on 1.12.2020.
//

import UIKit

protocol Reusable {
    
    static var reuseID: String { get }
}

extension Reusable {
    
    static var reuseID: String {
        return String(describing: self)
    }
}

// MARK: - View Controller

extension UIViewController: Reusable {}

extension UIStoryboard {
    
    public func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.reuseID) as? T else {
            fatalError("Unable to instantiate view controller: \(T.self). forgotten identifier naming.")
        }
        return viewController
    }
}

// MARK: - Collection View

extension UICollectionReusableView: Reusable {}

extension UICollectionView {
    
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable collection view cell: \(T.self)")
        }
        return cell
    }
    
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String,
                                                                       for indexPath: IndexPath) -> T {
        guard let section = dequeueReusableSupplementaryView(ofKind: kind,
                                                             withReuseIdentifier: T.reuseID,
                                                             for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable supplementary view: \(T.self)")
        }
        return section
    }
    
    public func registerCell<T: UICollectionViewCell>(for type: T.Type) {
        register(UINib(nibName: T.reuseID, bundle: Bundle(for: type)), forCellWithReuseIdentifier: T.reuseID)
    }
    
    final func register<T: UICollectionReusableView>(for type: T.Type, ofKind elementKind: String) {
          self.register(
            UINib(nibName: T.reuseID, bundle: Bundle(for: type)),
            forSupplementaryViewOfKind: elementKind,
            withReuseIdentifier: type.reuseID
          )
      }
    
}

// MARK: - Table View

extension UITableViewCell: Reusable {}

extension UITableView {
    
    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseID,
                                             for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable table view cell: \(T.self)")
        }
        
        return cell
    }
    
    public func registerCell<T: UITableViewCell>(for type: T.Type) {
        register(UINib(nibName: T.reuseID, bundle: Bundle(for: type)), forCellReuseIdentifier: T.reuseID)
    }
}
