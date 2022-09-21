//
//  UITabBarItem+AndesBadgeExtension.swift
//  AndesUI
//
//  Created by Julián Lima on 22/01/2021.
//  Copyright © 2021 MercadoPago. All rights reserved.
//

@objc public extension UITabBarItem {
    func setAndesBadge(with value: Int) {
        guard value > 0 else {
            removeAndesBadge()
            return
        }

        let stringValue: String = value > 99 ? "99+" : String(value)
        removeAndesBadge()
        badgeValue = stringValue
        updateBadge(value: stringValue)
    }

    func removeAndesBadge() {
        guard let badgeView = getBadgeView() else { return }

        badgeValue = ""
        badgeView.subviews.forEach { $0.removeFromSuperview() }
    }

    private func getBadgeView() -> UIView? {
        guard let parentView = self.value(forKey: "view") as? UIView else { return nil }

        for subview in parentView.subviews {
            if NSStringFromClass(subview.classForCoder) == "_UIBadgeView" {
                return subview
            }
        }
        return nil
    }

    private func updateBadge(value: String) {
        guard let view = getBadgeView() else {
            removeAndesBadge()
            return
        }

        badgeColor = .clear
        view.backgroundColor = .clear

        let pillView = AndesBadgePill(hierarchy: .loud, type: .error, border: .standard, size: .small, text: value)
        view.addSubview(pillView)
        pillView.topAnchor.constraint(equalTo: view.topAnchor, constant: 1).isActive = true
        pillView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -4).isActive = true
    }
}
