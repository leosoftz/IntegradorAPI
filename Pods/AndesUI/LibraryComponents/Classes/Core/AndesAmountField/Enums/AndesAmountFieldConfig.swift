//
//  AndesAmountFieldConfig.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 24/03/2022.
//

import Foundation

@objc
public class AndesAmountFieldConfig: NSObject {
    public let inputConfig: AndesAmountFieldInputConfig
    public let inputLimits: AndesAmountFieldInputLimits
    public let textConfig: AndesAmountFieldTextConfig

    @objc
    public init(inputConfig: AndesAmountFieldInputConfig,
         inputLimits: AndesAmountFieldInputLimits,
         textConfig: AndesAmountFieldTextConfig) {
        self.inputConfig = inputConfig
        self.inputLimits = inputLimits
        self.textConfig = textConfig
    }
}
