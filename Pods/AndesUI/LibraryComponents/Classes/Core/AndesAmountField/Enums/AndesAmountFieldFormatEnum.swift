//
//  AndesAmountFieldFormatEnum.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 05/03/2022.
//

import Foundation

enum AndesAmountFieldFormatEnum {
    case extraSmall
    case small
    case medium
    case large

    func formatConfig(type: AndesAmountFieldType, initial: Bool) -> AndesAmountFieldFormatConfig {
        var suffixColor: UIColor
        switch type {
        case .currency:
            suffixColor = AndesStyleSheetManager.styleSheet.textColorSecondary
        case .percentage:
            suffixColor = initial ? AndesStyleSheetManager.styleSheet.textColorSecondary : AndesStyleSheetManager.styleSheet.textColorPrimary
        }

        let textColor = initial ? AndesStyleSheetManager.styleSheet.textColorSecondary : AndesStyleSheetManager.styleSheet.textColorPrimary

        switch self {
        case .extraSmall:
            return AndesAmountFieldFormatConfig(fontStyleCurrency:
                                                    self.configStyle(size: 18, color: textColor, lineHeight: 23)
                                                ,
                                                fontStyleAmount: self.configStyle(size: 18, color: textColor, lineHeight: 23)
                                                ,
                                                fontStyleSuffix: self.configStyle(size: 18, color: suffixColor, lineHeight: 23),
                                                interSpace: 4.0)

        case .small:
            return AndesAmountFieldFormatConfig(fontStyleCurrency:
                                                    self.configStyle(size: 18, color: textColor, lineHeight: 23)

                                                ,
                                                fontStyleAmount: self.configStyle(size: 36, color: textColor, lineHeight: 45)
                                                ,
                                                fontStyleSuffix: self.configStyle(size: 24, color: suffixColor, lineHeight: 30),
                                                interSpace: 4.0)
        case .medium:

            return AndesAmountFieldFormatConfig(fontStyleCurrency: self.configStyle(size: 22, color: textColor, lineHeight: 28),
                                                fontStyleAmount: self.configStyle(size: 44, color: textColor, lineHeight: 55),
                                                fontStyleSuffix: self.configStyle(size: 28, color: suffixColor, lineHeight: 35),
                                                interSpace: 6.0)
        case .large:

            return AndesAmountFieldFormatConfig(fontStyleCurrency: self.configStyle(size: 28, color: textColor, lineHeight: 35),
                                                fontStyleAmount: self.configStyle(size: 56, color: textColor, lineHeight: 70),
                                                fontStyleSuffix: self.configStyle(size: 36, color: suffixColor, lineHeight: 45),
                                                interSpace: 8.0)
        }
    }

    func nextLevel() -> AndesAmountFieldFormatEnum {
        switch self {
        case .extraSmall:
            return AndesAmountFieldFormatEnum.small

        case .small:
            return AndesAmountFieldFormatEnum.medium
        case .medium:
            return AndesAmountFieldFormatEnum.large
        case .large:
            return AndesAmountFieldFormatEnum.large
        }
    }

    func previousLevel() -> AndesAmountFieldFormatEnum {
        switch self {
        case .extraSmall:
            return AndesAmountFieldFormatEnum.extraSmall

        case .small:
            return AndesAmountFieldFormatEnum.extraSmall
        case .medium:
            return AndesAmountFieldFormatEnum.small
        case .large:
            return AndesAmountFieldFormatEnum.medium
        }
    }

    private func configStyle(size: CGFloat, color: UIColor, lineHeight: CGFloat) -> AndesFontStyle {
        return  AndesFontStyle(textColor: color,
                               font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: size),
                               lineSpacing: 0,
                               fontLineHeight: lineHeight)
    }
}

struct AndesAmountFieldFormatConfig {
    let fontStyleCurrency: AndesFontStyle
    let fontStyleAmount: AndesFontStyle
    let fontStyleSuffix: AndesFontStyle
    let interSpace: CGFloat
}
