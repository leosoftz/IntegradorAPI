//
//  AndesAmountFieldInputFromInteger.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 03/03/2022.
//

import Foundation

class AndesAmountFieldInputFromInteger: AndesAmountFieldInputModeProtocol {
    internal let configInput: AndesAmountFieldInputConfig
    internal let configLimit: AndesAmountFieldInputLimits
    internal let valueFormatter: NumberFormatter
    private var formattedValue: String
    private var numberDecimal: Decimal
    private var decimalEntry: Bool = false
    private var decimalString: String

    required init(configInput: AndesAmountFieldInputConfig, configLimit: AndesAmountFieldInputLimits, valueFormatter: NumberFormatter) {
        self.configInput = configInput
        self.configLimit = configLimit
        self.valueFormatter = valueFormatter
        self.formattedValue = "0"
        self.numberDecimal = 0.0
        self.valueFormatter.minimumFractionDigits = 0
        self.decimalString = ""
   }

    func setInitialWith(value: Decimal) -> AmountFieldValue? {
        let oldDecimal = self.numberDecimal
        let newValue = AndesAmountFieldInputManager.limit(number: value, actualNumber: oldDecimal, configLimit: self.configLimit, decimalPlaces: self.configInput.decimalPlaces, overflow: false)
        let nsNumber = newValue as NSNumber
        if let newValueStr = self.valueFormatter.string(from: nsNumber) {
            self.formattedValue = newValueStr
            self.numberDecimal = newValue
        } else {
            self.numberDecimal = oldDecimal // Roolback the original value
        }
        if isHasDecimals() {
            let integerPart = (self.numberDecimal as NSDecimalNumber).intValue
            let integerPartNSDecimal = NSDecimalNumber(value: integerPart)
            let decimalNumber: NSDecimalNumber = NSDecimalNumber(decimal: self.numberDecimal)
            let decimalPartNumber = decimalNumber.decimalValue - integerPartNSDecimal.decimalValue
            self.decimalString = (valueFormatter.string(from: (decimalPartNumber as NSDecimalNumber)) ?? "").replacingOccurrences(of: "0" + self.configInput.decimalSeparator, with: "")
            self.decimalEntry = true
        }
        return (self.numberDecimal, self.formattedValue)
    }

    private func isHasDecimals() -> Bool {
        let integerPart = (self.numberDecimal as NSDecimalNumber).intValue
        let integerPartNSDecimal = NSDecimalNumber(value: integerPart)
        let decimalNumber: NSDecimalNumber = NSDecimalNumber(decimal: self.numberDecimal)
        let decimalPartNumber = decimalNumber.decimalValue - integerPartNSDecimal.decimalValue
        return  abs(decimalPartNumber) > 0
    }

    func deleteBackward() -> AmountFieldValue? {
        let oldDecimal = self.numberDecimal
        var newValue: Decimal = 0
        var isLastDecimal = false

        if isHasDecimals() {
            let integerPart = (self.numberDecimal as NSDecimalNumber).intValue
            let integerPartStr = integerPart.description
            _ = self.decimalString.popLast()
            let intermediateTrunc = integerPartStr + self.configInput.decimalSeparator + self.decimalString
            if let numberFromStrings = valueFormatter.number(from: intermediateTrunc) {
                newValue = numberFromStrings.decimalValue
            } else {
                newValue = oldDecimal
            }
            if self.decimalString.count == 0 { isLastDecimal = true }
        } else if self.decimalEntry == true && self.decimalString == "" {
            newValue = self.numberDecimal
            self.decimalEntry = false
        } else if self.decimalEntry == true && self.decimalString != "" {
            newValue = self.numberDecimal
            _ = self.decimalString.popLast()
            if self.decimalString.count == 0 { isLastDecimal = true }
        } else {
            newValue = self.numberDecimal / 10
            newValue = Decimal(NSDecimalNumber(decimal: newValue).intValue)
        }
        let nsNumber = newValue as NSNumber
        if let newValueStr = self.valueFormatter.string(from: nsNumber) {
            self.formattedValue = newValueStr
            self.numberDecimal = newValue

            if isLastDecimal {
                self.formattedValue = self.formattedValue + self.configInput.decimalSeparator
            }
            if let last = self.decimalString.last, last == "0" {
                self.formattedValue = self.formattedValue + self.configInput.decimalSeparator + self.decimalString
            }
        } else {
            self.numberDecimal = oldDecimal // Roolback the original value
        }

        return (self.numberDecimal, self.formattedValue)
    }

    private func addSeparator(numberString: String) -> String {
        return numberString + self.configInput.decimalSeparator
    }

    private func formatWithZeroDigits(number: Decimal, decimalString: String) -> String {
        let integerPart = (number as NSDecimalNumber).intValue
        let integerPartStr = integerPart.description
        let newValueStr = integerPartStr + self.configInput.decimalSeparator + decimalString
        return newValueStr
    }

    func format(input: String) -> AmountFieldValue? {
        let oldDecimal = self.numberDecimal
        var newValue: Decimal?
        var enableDecimalSeparator: Bool = false

        if input == self.configInput.decimalSeparator && self.decimalEntry == false && self.configInput.decimalPlaces > 0 {
            enableDecimalSeparator = true
        } else if input == self.configInput.decimalSeparator && self.decimalEntry == true {
            enableDecimalSeparator = false
        } else if let inputInt = Int(input) {
            if self.decimalEntry == false {
                newValue = self.numberDecimal * 10 + Decimal(inputInt)
            } else {
                let actualDigits = self.decimalString.count
                if actualDigits < self.configInput.decimalPlaces {
                    self.decimalString = self.decimalString + input
                    let integerPart = (self.numberDecimal as NSDecimalNumber).intValue
                    let integerPartStr = integerPart.description
                    let newValueStr = integerPartStr + self.configInput.decimalSeparator + self.decimalString
                    if let numberFromStrings = valueFormatter.number(from: newValueStr) {
                        newValue = numberFromStrings.decimalValue
                    } else {
                        newValue = oldDecimal
                    }
                }
            }
        }

        if var newValue = newValue {
            newValue = AndesAmountFieldInputManager.limit(number: newValue, actualNumber: oldDecimal, configLimit: self.configLimit, decimalPlaces: self.configInput.decimalPlaces, overflow: true)
            let nsNumber = newValue as NSNumber
            if let newValueStr = self.valueFormatter.string(from: nsNumber) {
                self.formattedValue = newValueStr
                self.numberDecimal = newValue
            } else {
                self.numberDecimal = oldDecimal // Roolback the original value
            }

            if self.decimalEntry == true && input == "0" {
                if self.decimalString.last == "0" {
                    self.formattedValue = self.formatWithZeroDigits(number: self.numberDecimal, decimalString: self.decimalString)
                } else {
                    self.formattedValue = self.formattedValue + input
                }
            }
        } else {
            if enableDecimalSeparator {
                self.formattedValue = self.formattedValue + self.configInput.decimalSeparator
                self.decimalEntry = true
            }
        }

        return (self.numberDecimal, self.formattedValue)
    }
}
