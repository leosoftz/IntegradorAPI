//
//  AndesAmountFieldTextConfig.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 24/03/2022.
//

import Foundation

@objc
public class AndesAmountFieldTextConfig: NSObject {
    public let currencySymbol: String?
    public let suffixText: String?

    @objc
    public init (currencySymbol: String?, suffixText: String?) {
        self.currencySymbol = currencySymbol
        self.suffixText = suffixText
    }
    override public var description: String {
        return ("CurrencySymbol:\(String(describing: self.currencySymbol)) SuffixText:\(String(describing: self.suffixText))")
    }
}
