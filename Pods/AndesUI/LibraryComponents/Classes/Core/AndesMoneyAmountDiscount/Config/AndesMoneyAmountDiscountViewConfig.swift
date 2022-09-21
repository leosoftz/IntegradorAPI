//
//  
//  AndesDiscountViewConfig.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 1/09/21.
//
//

import Foundation

/// used to define the ui of internal AndesDiscount views
internal struct AndesMoneyAmountDiscountViewConfig {
    let discountValue: Int?
    let size: AndesMoneyAmountSize?
    let icon: UIImage?
    let showIcon: Bool

    init(discountValue: Int? = nil,
         size: AndesMoneyAmountSize? = nil,
         icon: UIImage? = nil,
         showIcon: Bool = false) {
        self.discountValue = discountValue
        self.size = size
        self.icon = icon
        self.showIcon = showIcon
    }
}
