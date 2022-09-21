//
//  AndesTextFieldComponentProgressIndicator.swift
//  AndesUI
//
//  Created by Santiago Lazzari on 14/05/2021.
//

import UIKit

@objc public class AndesTextFieldComponentProgressIndicator: NSObject, AndesTextFieldRightComponent {
    public private(set) var visibility: AndesTextFieldComponentVisibility = .always
    public private(set) var reloadPolicy: AndesTextFieldComponentReloadPolicy = .onlyOneTime

    @objc public private(set) var tintColor: UIColor = .clear

    @objc public convenience init(tintColor: UIColor) {
        self.init()
        self.tintColor = tintColor
    }
}
