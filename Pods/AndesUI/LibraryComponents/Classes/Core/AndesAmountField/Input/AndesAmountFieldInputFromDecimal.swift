//
//  AndesAmountFieldInputFromDecimal.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 03/03/2022.
//

import Foundation

class AndesAmountFieldInputFromDecimal: AndesAmountFieldInputModeProtocol {
    internal let configInput: AndesAmountFieldInputConfig
    internal let configLimit: AndesAmountFieldInputLimits
    internal let valueFormatter: NumberFormatter

    private var formattedValue: String
    private var numberDecimal: Decimal

    required init(configInput: AndesAmountFieldInputConfig, configLimit: AndesAmountFieldInputLimits, valueFormatter: NumberFormatter) {
        self.configInput = configInput
        self.configLimit = configLimit
        self.valueFormatter = valueFormatter
        self.formattedValue = "0"
        self.numberDecimal = 0
    }

    func setInitialWith(value: Decimal) -> AmountFieldValue? {
        let oldDecimal = self.numberDecimal
        let newValue = AndesAmountFieldInputManager.limit(number: value, actualNumber: oldDecimal, configLimit: self.configLimit, decimalPlaces: self.configInput.decimalPlaces, overflow: false)
        let nsNumber = newValue as NSNumber
        if let newValueStr = self.valueFormatter.string(from: nsNumber) {
            self.formattedValue = newValueStr
            self.numberDecimal = nsNumber.decimalValue
        } else {
            self.numberDecimal = oldDecimal // Roolback the original value
        }
        return (self.numberDecimal, self.formattedValue)
    }

    func deleteBackward() -> AmountFieldValue? {
        let oldDecimal = self.numberDecimal
        var processValue = self.numberDecimal / 10
        processValue = AndesAmountFieldInputManager.limit(number: processValue, actualNumber: oldDecimal, configLimit: self.configLimit, decimalPlaces: self.configInput.decimalPlaces, overflow: true)
        let nsNumber = processValue as NSNumber
        if let newValueStr = self.valueFormatter.string(from: nsNumber), let newValueDec = self.valueFormatter.number(from: newValueStr)?.decimalValue {
            self.formattedValue = newValueStr
            self.numberDecimal = newValueDec
        }
        return (self.numberDecimal, self.formattedValue)
    }

    func format(input: String) -> AmountFieldValue? {
        let oldDecimal = self.numberDecimal
        let positionValue = 1.0 / (NSDecimalNumber(10).raising(toPower: self.configInput.decimalPlaces) as Decimal)
        let processValueAdd = NSDecimalNumber(string: input).decimalValue * positionValue
        var processValue = self.numberDecimal * 10 + processValueAdd
        processValue = AndesAmountFieldInputManager.limit(number: processValue, actualNumber: oldDecimal, configLimit: self.configLimit, decimalPlaces: self.configInput.decimalPlaces, overflow: true)
        let nsNumber = processValue as NSNumber
        if let newValueStr = self.valueFormatter.string(from: nsNumber) {
            self.formattedValue = newValueStr
            self.numberDecimal = processValue
        }
        return (self.numberDecimal, self.formattedValue)
    }
}
