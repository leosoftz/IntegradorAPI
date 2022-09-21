//
//  
//  AndesDiscountViewConfigFactory.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 1/09/21.
//
//

import Foundation

internal class AndesMoneyAmountDiscountViewConfigFactory {
    static func provideInternalConfig(discountValue: Int,
                                      size: AndesMoneyAmountSize,
                                      icon: UIImage?, showIcon: Bool) -> AndesMoneyAmountDiscountViewConfig {
        let config = AndesMoneyAmountDiscountViewConfig(discountValue: discountValue, size: size, icon: icon, showIcon: showIcon)
        return config
    }
}
