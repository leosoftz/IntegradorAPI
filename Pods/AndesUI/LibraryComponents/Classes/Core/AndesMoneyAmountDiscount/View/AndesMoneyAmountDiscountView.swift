//
//  
//  AndesDiscountView.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 1/09/21.
//
//

import Foundation

/**
 Internal protocol that specifies the behaviour a view must provide to be a valid representation of an AndesDiscount
 */
internal protocol AndesMoneyAmountDiscountView: UIView {
    func update(withConfig config: AndesMoneyAmountDiscountViewConfig)
}
