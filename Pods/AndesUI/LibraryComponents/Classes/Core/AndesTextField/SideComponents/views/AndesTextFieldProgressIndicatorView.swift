//
//  AndesTextFieldProgressIndicatorView.swift
//  AndesUI
//
//  Created by Santiago Lazzari on 14/05/2021.
//

import UIKit

class AndesTextFieldProgressIndicatorView: UIView {
    @objc public private(set) var progressIndicatorColor: UIColor = .clear

    convenience init(progressIndicatorColor: UIColor) {
        self.init()

        self.progressIndicatorColor = progressIndicatorColor

        setUp()
    }

    func setUp() {
        let progresIndicator = AndesProgressIndicatorIndeterminate(size: .xSmall, tint: progressIndicatorColor)
        progresIndicator.translatesAutoresizingMaskIntoConstraints = false
        progresIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        progresIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.addSubview(progresIndicator)
        progresIndicator.pinToSuperview(top: 0, left: 12, bottom: 0, right: 12)
        progresIndicator.startAnimation()
        self.isUserInteractionEnabled = false
    }
}
