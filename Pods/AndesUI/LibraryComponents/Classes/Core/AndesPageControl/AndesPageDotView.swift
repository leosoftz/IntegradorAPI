//
//  AndesPageDotView.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 13/04/2021.
//

import UIKit

final class AndesPageDotLayer: CAShapeLayer {
    init(size: CGFloat) {
        super.init()
        self.bounds = CGRect(origin: .zero, size: CGSize(width: size, height: size))
        updateCornerRadius()
    }

    override init(layer: Any) {
        super.init(layer: layer)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    private func updateCornerRadius() {
        masksToBounds = true
        cornerRadius = min(bounds.width, bounds.height) / 2
    }
}
