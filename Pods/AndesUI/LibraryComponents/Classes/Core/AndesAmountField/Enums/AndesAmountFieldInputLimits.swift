//
//  AndesAmountFieldInputLimits.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 24/03/2022.
//

import Foundation

@objc
public class AndesAmountFieldInputLimits: NSObject {
    public let maxShowedValue: Decimal
    public let maxValue: Decimal

    @objc
    public init (maxValue: Decimal) {
        self.maxValue = maxValue
        self.maxShowedValue = maxValue * 10
    }

    override public var description: String {
        return ("MaxValue\(maxValue.description) MaxShowedValue:\(self.maxShowedValue) ")
    }
}
