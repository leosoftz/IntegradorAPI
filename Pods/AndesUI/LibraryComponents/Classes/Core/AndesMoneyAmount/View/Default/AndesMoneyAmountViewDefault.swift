//
//  
//  AndesMoneyAmountDiscountViewDefault.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 24/08/21.
//
//

import Foundation

class AndesMoneyAmountViewDefault: AndesMoneyAmountAbstractView {
    override func updateView() {
        super.updateView()
    }

    @objc
    override public var intrinsicContentSize: CGSize {
        self.setNeedsLayout()
        self.layoutIfNeeded()

        return CGSize(width: self.bounds.width, height: self.bounds.height)
    }
}
