//
//  UIView+Additions.swift
//  AndesUI
//
//  Created by Nicolas Rostan Talasimov on 3/24/20.
//

import Foundation

internal extension UIView {
    func pinToSuperview() {
        guard let superview = self.superview else {
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }

    func pinToSuperview(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        guard let superview = self.superview else {
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: left).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -right).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom).isActive = true
    }

    func setCornerRadius(cornerRadius: CGFloat, roundedCorners: CACornerMask) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = roundedCorners
    }

    func setRectangleShape(tint: UIColor? = nil, cornerRadius: CGFloat?, roundedCorners: CACornerMask?) {
        if let cornerRadius = cornerRadius, let roundedCorners = roundedCorners {
            self.layer.backgroundColor = tint?.cgColor
            self.setCornerRadius(cornerRadius: cornerRadius, roundedCorners: roundedCorners)
        }
    }

    func setRectangleShapeWithBorder(tint: UIColor? = nil, borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat, roundedCorners: CACornerMask) {
        self.setRectangleShape(tint: tint, cornerRadius: cornerRadius, roundedCorners: roundedCorners)
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }

    func setRectangleShapeWithDashedLine(tint: UIColor? = nil, borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        let borderLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius)
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineDashPattern = [2, 2]
        borderLayer.frame = self.bounds
        borderLayer.fillColor = tint?.cgColor
        borderLayer.cornerRadius = cornerRadius
        borderLayer.lineWidth = borderWidth
        borderLayer.path = path.cgPath

        self.layer.addSublayer(borderLayer)
    }

    func firstSuperViewOf<SuperView: UIView>(type parentClass: SuperView.Type) -> SuperView? {
        return superview as? SuperView ?? superview?.firstSuperViewOf(type: parentClass)
    }
}

internal extension UIEdgeInsets {
    var horizontally: CGFloat { self.left + self.right }
    var vertically: CGFloat { self.top + self.bottom }
}
