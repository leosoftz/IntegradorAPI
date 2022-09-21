//
//  AndesAmountFieldViewValues.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 11/04/2022.
//

import Foundation

struct AndesAmountFieldViewValues {
    var suffixText: String?
    var currencyText: String?
    var helperText: String?
    var numberText: String?

    func generalA11yText() -> String {
        var a11yText = ""
        if let currencyText = currencyText {
            a11yText += currencyText
        }
        if let suffixText = suffixText {
            a11yText += suffixText + ","
        }
        if let helperText = helperText {
            a11yText += helperText
        }
        return a11yText
    }
}
