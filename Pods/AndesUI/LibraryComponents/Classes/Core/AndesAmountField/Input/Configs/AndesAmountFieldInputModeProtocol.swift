//
//  AndesAmountFieldInputModeProtocol.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 24/03/2022.
//

import Foundation

protocol AndesAmountFieldInputModeProtocol {
    var configInput: AndesAmountFieldInputConfig { get }
    var configLimit: AndesAmountFieldInputLimits { get }
    var valueFormatter: NumberFormatter { get }

    init (configInput: AndesAmountFieldInputConfig, configLimit: AndesAmountFieldInputLimits, valueFormatter: NumberFormatter)
    func deleteBackward() -> AmountFieldValue?
    func format(input: String) -> AmountFieldValue?
    func setInitialWith(value: Decimal) -> AmountFieldValue?
}
