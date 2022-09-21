//
//  DefaultsInputStepper.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 19/01/22.
//

import Foundation
import UIKit

@objc public class DefaultsInputStepper: NSObject {
    @objc public static let size: AndesInputStepperSize = .large
    @objc public static let maxValue: Int = 10
    @objc public static let minValue: Int = 0
    @objc public static let step: Int = 1
    @objc public static let loading: Bool = false
    @objc public static let enabled: Bool = true
    @objc public static let pressedColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor300
    @objc public static let idleColor: UIColor = UIColor.Andes.white
    @objc public static let tint: UIColor = AndesStyleSheetManager.styleSheet.accentColor
    @objc public static let grayColor: UIColor = AndesStyleSheetManager.styleSheet.textColorDisabled
    @objc public static let textColor: UIColor = AndesStyleSheetManager.styleSheet.textColorSecondary
    @objc public static let disabledColor: UIColor = UIColor.Andes.gray040
    @objc public static let stepperTransitionDuration: TimeInterval = 0.2
    @objc public static let stepperTransitionPosition: CGFloat = 36

    internal static func createConfig() -> AndesInputStepperViewConfig {
        return AndesInputStepperViewConfigFactory.provideInternalConfig(
            size: DefaultsInputStepper.size,
            maxValue: DefaultsInputStepper.maxValue,
            minValue: DefaultsInputStepper.minValue,
            step: DefaultsInputStepper.step,
            value: DefaultsInputStepper.minValue)
    }
}
