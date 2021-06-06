//
//  UIStackView+Util.swift
//  CoreUI
//
//  Created by hsncr on 1.12.2020.
//
//  https://gist.github.com/Deub27/5eadbf1b77ce28abd9b630eadb95c1e2

import UIKit

extension UIStackView {
    
    @discardableResult
    public func removeAllArrangedSubviews() -> [UIView] {
        return arrangedSubviews.reduce([UIView]()) { $0 + [removeArrangedSubViewProperly($1)] }
    }

    private func removeArrangedSubViewProperly(_ view: UIView) -> UIView {
        removeArrangedSubview(view)
        NSLayoutConstraint.deactivate(view.constraints)
        view.removeFromSuperview()
        return view
    }
}
