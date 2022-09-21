//
//  AndesColorStrategyiOS.swift
//  AndesUI
//
//  Created by LEANDRO FURYK on 05/12/2019.
//

import Foundation

public class AndesColorStrategyiOS: AndesColors {
    public var bgColorPrimary: UIColor = UIColor(named: "andes-bg-color-primary", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var bgColorSecondary: UIColor = UIColor(named: "andes-bg-color-secondary", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var bgColorWhite: UIColor = UIColor(named: "andes-bg-color-white", in: AndesBundle.bundle(), compatibleWith: nil)!

    public var brandColor500: UIColor = UIColor(named: "andes-brand-color-500", in: AndesBundle.bundle(), compatibleWith: nil)!

    public var accentColor: UIColor = UIColor(named: "andes-accent-color-500", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var accentColor100: UIColor = UIColor(named: "andes-accent-color-100", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var accentColor150: UIColor = UIColor(named: "andes-accent-color-150", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var accentColor200: UIColor = UIColor(named: "andes-accent-color-200", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var accentColor300: UIColor = UIColor(named: "andes-accent-color-300", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var accentColor400: UIColor = UIColor(named: "andes-accent-color-400", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var accentColor500: UIColor = UIColor(named: "andes-accent-color-500", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var accentColor600: UIColor = UIColor(named: "andes-accent-color-600", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var accentColor700: UIColor = UIColor(named: "andes-accent-color-700", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var accentColor800: UIColor = UIColor(named: "andes-accent-color-800", in: AndesBundle.bundle(), compatibleWith: nil)!

    public var textColorPrimary: UIColor = UIColor(named: "andes-text-color-primary", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var textColorSecondary: UIColor = UIColor(named: "andes-text-color-secondary", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var textColorDisabled: UIColor = UIColor(named: "andes-text-color-disabled", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var textColorNegative: UIColor = UIColor(named: "andes-text-color-negative", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var textColorCaution: UIColor = UIColor(named: "andes-text-color-caution", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var textColorPositive: UIColor = UIColor(named: "andes-text-color-positive", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var tetColorLink: UIColor = UIColor(named: "andes-text-color-link", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var textColorLink: UIColor = UIColor(named: "andes-text-color-link", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var textColorWhite: UIColor = UIColor(named: "andes-text-color-white", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var textColorWarning: UIColor = UIColor(named: "andes-text-color-warning", in: AndesBundle.bundle(), compatibleWith: nil)!

    public var feedbackColorNegative: UIColor = UIColor(named: "andes-feedback-color-red", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var feedbackColorPositive: UIColor = UIColor(named: "andes-feedback-color-green", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var feedbackColorCaution: UIColor = UIColor(named: "andes-feedback-color-orange", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var feedbackColorWarning: UIColor = UIColor(named: "andes-feedback-color-warning", in: AndesBundle.bundle(), compatibleWith: nil)!

    /// Secondary colors
    public var secondaryA100: UIColor = UIColor(named: "andes-secondary-a-100", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryA200: UIColor = UIColor(named: "andes-secondary-a-200", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryA300: UIColor = UIColor(named: "andes-secondary-a-300", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryA400: UIColor = UIColor(named: "andes-secondary-a-400", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryA500: UIColor = UIColor(named: "andes-secondary-a-500", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryA600: UIColor = UIColor(named: "andes-secondary-a-600", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryA700: UIColor = UIColor(named: "andes-secondary-a-700", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryA800: UIColor = UIColor(named: "andes-secondary-a-800", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryA900: UIColor = UIColor(named: "andes-secondary-a-900", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryB100: UIColor = UIColor(named: "andes-secondary-b-100", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryB200: UIColor = UIColor(named: "andes-secondary-b-200", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryB300: UIColor = UIColor(named: "andes-secondary-b-300", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryB400: UIColor = UIColor(named: "andes-secondary-b-400", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryB500: UIColor = UIColor(named: "andes-secondary-b-500", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryB600: UIColor = UIColor(named: "andes-secondary-b-600", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryB700: UIColor = UIColor(named: "andes-secondary-b-700", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryB800: UIColor = UIColor(named: "andes-secondary-b-800", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryB900: UIColor = UIColor(named: "andes-secondary-b-900", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryC100: UIColor = UIColor(named: "andes-secondary-c-100", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryC200: UIColor = UIColor(named: "andes-secondary-c-200", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryC300: UIColor = UIColor(named: "andes-secondary-c-300", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryC400: UIColor = UIColor(named: "andes-secondary-c-400", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryC500: UIColor = UIColor(named: "andes-secondary-c-500", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryC600: UIColor = UIColor(named: "andes-secondary-c-600", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryC700: UIColor = UIColor(named: "andes-secondary-c-700", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryC800: UIColor = UIColor(named: "andes-secondary-c-800", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryC900: UIColor = UIColor(named: "andes-secondary-c-900", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryD100: UIColor = UIColor(named: "andes-secondary-d-100", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryD200: UIColor = UIColor(named: "andes-secondary-d-200", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryD300: UIColor = UIColor(named: "andes-secondary-d-300", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryD400: UIColor = UIColor(named: "andes-secondary-d-400", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryD500: UIColor = UIColor(named: "andes-secondary-d-500", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryD600: UIColor = UIColor(named: "andes-secondary-d-600", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryD700: UIColor = UIColor(named: "andes-secondary-d-700", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryD800: UIColor = UIColor(named: "andes-secondary-d-800", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryD900: UIColor = UIColor(named: "andes-secondary-d-900", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryE100: UIColor = UIColor(named: "andes-secondary-e-100", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryE200: UIColor = UIColor(named: "andes-secondary-e-200", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryE300: UIColor = UIColor(named: "andes-secondary-e-300", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryE400: UIColor = UIColor(named: "andes-secondary-e-400", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryE500: UIColor = UIColor(named: "andes-secondary-e-500", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryE600: UIColor = UIColor(named: "andes-secondary-e-600", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryE700: UIColor = UIColor(named: "andes-secondary-e-700", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryE800: UIColor = UIColor(named: "andes-secondary-e-800", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryE900: UIColor = UIColor(named: "andes-secondary-e-900", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryF100: UIColor = UIColor(named: "andes-secondary-f-100", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryF200: UIColor = UIColor(named: "andes-secondary-f-200", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryF300: UIColor = UIColor(named: "andes-secondary-f-300", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryF400: UIColor = UIColor(named: "andes-secondary-f-400", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryF500: UIColor = UIColor(named: "andes-secondary-f-500", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryF600: UIColor = UIColor(named: "andes-secondary-f-600", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryF700: UIColor = UIColor(named: "andes-secondary-f-700", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryF800: UIColor = UIColor(named: "andes-secondary-f-800", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryF900: UIColor = UIColor(named: "andes-secondary-f-900", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryG100: UIColor = UIColor(named: "andes-secondary-g-100", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryG200: UIColor = UIColor(named: "andes-secondary-g-200", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryG300: UIColor = UIColor(named: "andes-secondary-g-300", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryG400: UIColor = UIColor(named: "andes-secondary-g-400", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryG500: UIColor = UIColor(named: "andes-secondary-g-500", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryG600: UIColor = UIColor(named: "andes-secondary-g-600", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryG700: UIColor = UIColor(named: "andes-secondary-g-700", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryG800: UIColor = UIColor(named: "andes-secondary-g-800", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryG900: UIColor = UIColor(named: "andes-secondary-g-900", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryH100: UIColor = UIColor(named: "andes-secondary-h-100", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryH200: UIColor = UIColor(named: "andes-secondary-h-200", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryH300: UIColor = UIColor(named: "andes-secondary-h-300", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryH400: UIColor = UIColor(named: "andes-secondary-h-400", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryH500: UIColor = UIColor(named: "andes-secondary-h-500", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryH600: UIColor = UIColor(named: "andes-secondary-h-600", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryH700: UIColor = UIColor(named: "andes-secondary-h-700", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryH800: UIColor = UIColor(named: "andes-secondary-h-800", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryH900: UIColor = UIColor(named: "andes-secondary-h-900", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryI100: UIColor = UIColor(named: "andes-secondary-i-100", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryI200: UIColor = UIColor(named: "andes-secondary-i-200", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryI300: UIColor = UIColor(named: "andes-secondary-i-300", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryI400: UIColor = UIColor(named: "andes-secondary-i-400", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryI500: UIColor = UIColor(named: "andes-secondary-i-500", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryI600: UIColor = UIColor(named: "andes-secondary-i-600", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryI700: UIColor = UIColor(named: "andes-secondary-i-700", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryI800: UIColor = UIColor(named: "andes-secondary-i-800", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryI900: UIColor = UIColor(named: "andes-secondary-i-900", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryJ100: UIColor = UIColor(named: "andes-secondary-j-100", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryJ200: UIColor = UIColor(named: "andes-secondary-j-200", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryJ300: UIColor = UIColor(named: "andes-secondary-j-300", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryJ400: UIColor = UIColor(named: "andes-secondary-j-400", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryJ500: UIColor = UIColor(named: "andes-secondary-j-500", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryJ600: UIColor = UIColor(named: "andes-secondary-j-600", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryJ700: UIColor = UIColor(named: "andes-secondary-j-700", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryJ800: UIColor = UIColor(named: "andes-secondary-j-800", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryJ900: UIColor = UIColor(named: "andes-secondary-j-900", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryK100: UIColor = UIColor(named: "andes-secondary-k-100", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryK200: UIColor = UIColor(named: "andes-secondary-k-200", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryK300: UIColor = UIColor(named: "andes-secondary-k-300", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryK400: UIColor = UIColor(named: "andes-secondary-k-400", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryK500: UIColor = UIColor(named: "andes-secondary-k-500", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryK600: UIColor = UIColor(named: "andes-secondary-k-600", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryK700: UIColor = UIColor(named: "andes-secondary-k-700", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryK800: UIColor = UIColor(named: "andes-secondary-k-800", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryK900: UIColor = UIColor(named: "andes-secondary-k-900", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryL100: UIColor = UIColor(named: "andes-secondary-l-100", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryL200: UIColor = UIColor(named: "andes-secondary-l-200", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryL300: UIColor = UIColor(named: "andes-secondary-l-300", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryL400: UIColor = UIColor(named: "andes-secondary-l-400", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryL500: UIColor = UIColor(named: "andes-secondary-l-500", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryL600: UIColor = UIColor(named: "andes-secondary-l-600", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryL700: UIColor = UIColor(named: "andes-secondary-l-700", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryL800: UIColor = UIColor(named: "andes-secondary-l-800", in: AndesBundle.bundle(), compatibleWith: nil)!
    public var secondaryL900: UIColor = UIColor(named: "andes-secondary-l-900", in: AndesBundle.bundle(), compatibleWith: nil)!
}
