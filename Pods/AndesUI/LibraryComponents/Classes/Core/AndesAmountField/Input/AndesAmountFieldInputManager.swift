//
//  AndesAmountFieldInputManager.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 25/02/2022.
//

import Foundation

typealias AmountFieldValue = (valueDecimal: Decimal, valueString: String)
typealias AndesAmountFieldLimit = (Decimal, Bool)

class AndesAmountFieldInputManager {
    private(set) var actualValueRepresentation: String = ""
    private(set) var actualValueDecimalRepresentation: Decimal = 0
    private let config: AndesAmountFieldConfig

    private var processEntry: AndesAmountFieldInputModeProtocol?
    private var valueFormatter: NumberFormatter = NumberFormatter()

    init(initialValue: Decimal, config: AndesAmountFieldConfig) {
        self.config = config
        self.configureFormatter()
        self.actualValueDecimalRepresentation = initialValue
        switch config.inputConfig.entryMode {
        case .fromDecimal:
            self.processEntry = AndesAmountFieldInputFromDecimal(configInput: config.inputConfig, configLimit: config.inputLimits, valueFormatter: self.valueFormatter)
        case .fromInteger:
            self.processEntry = AndesAmountFieldInputFromInteger(configInput: config.inputConfig, configLimit: config.inputLimits, valueFormatter: self.valueFormatter)
        }
        guard let processEntry = self.processEntry  else { return }
        if let values = processEntry.setInitialWith(value: self.actualValueDecimalRepresentation) {
            self.actualValueRepresentation = values.valueString
            self.actualValueDecimalRepresentation = values.valueDecimal
        }
    }

    private func configureFormatter() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = self.config.inputConfig.decimalPlaces
        formatter.minimumFractionDigits = self.config.inputConfig.decimalPlaces
        formatter.decimalSeparator = self.config.inputConfig.decimalSeparator
        formatter.groupingSeparator = self.config.inputConfig.groupingSeparator
        formatter.groupingSize = self.config.inputConfig.groupingSize
        formatter.roundingMode = .down
        self.valueFormatter = formatter
    }

    private func valid(input: String) -> Bool {
        guard input.count == 1 else { return false }
        if  let integerInput = Int(input), integerInput > -1, integerInput < 10 {
            return true
        } else  if input == self.config.inputConfig.decimalSeparator && self.config.inputConfig.entryMode == .fromInteger {
            return true
        }
        return false
    }

    func format(input: String) -> AmountFieldValue {
        guard self.valid(input: input), let processEntry = self.processEntry  else { return (self.actualValueDecimalRepresentation, self.actualValueRepresentation) }
        if let values = processEntry.format(input: input) {
            self.actualValueRepresentation = values.valueString
            self.actualValueDecimalRepresentation = values.valueDecimal
        }
        return (self.actualValueDecimalRepresentation, self.actualValueRepresentation)
    }

    public func deleteBackward() -> AmountFieldValue {
        guard let processEntry = self.processEntry  else { return (self.actualValueDecimalRepresentation, self.actualValueRepresentation) }
        if let values = processEntry.deleteBackward() {
            self.actualValueRepresentation = values.valueString
            self.actualValueDecimalRepresentation = values.valueDecimal
        }
        return (self.actualValueDecimalRepresentation, self.actualValueRepresentation)
    }

    public func formatInputFrom(pastedDecimal: Decimal) -> AmountFieldValue {
        guard let processEntry = self.processEntry  else { return (self.actualValueDecimalRepresentation, self.actualValueRepresentation) }
        if let values = processEntry.setInitialWith(value: pastedDecimal) {
            self.actualValueRepresentation = values.valueString
            self.actualValueDecimalRepresentation = values.valueDecimal
        }
        return (self.actualValueDecimalRepresentation, self.actualValueRepresentation)
    }

    static func limit(number: Decimal, actualNumber: Decimal, configLimit: AndesAmountFieldInputLimits, decimalPlaces: Int, overflow: Bool) -> Decimal {
        let positionValue = decimalPlaces > 0 && overflow ? Decimal(0.1) : Decimal(0)
        let processValueAdd = 9 * positionValue
        let realMax = configLimit.maxShowedValue + processValueAdd
        switch number {
        case let x where x > realMax :
            return actualNumber
        case let x where x <= realMax && x >= 0:
            return number
        case let x where x < 0:
            return actualNumber
        default:
            return actualNumber
        }
    }
}
