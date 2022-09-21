//
//  AndesStyleSheet.swift
//  AndesUI
//
//  Created by LEANDRO FURYK on 04/12/2019.
//

import UIKit

@objc public protocol AndesStyleSheet: AndesColors, AndesFonts {}
@objc public protocol AndesColors: AndesPrimaryColors, AndesSecondaryColors {}
/**
  AndesColors is used to create a new StyleSheet
  implementing all the necessary colors
*/
@objc public protocol AndesPrimaryColors {
    /**
      The default colors that you need to override
      to use your color palette through all the UI components
    */
    var bgColorPrimary: UIColor { get }
    var bgColorSecondary: UIColor { get }
    var bgColorWhite: UIColor { get }

    var brandColor500: UIColor { get }

    var accentColor: UIColor { get }
    var accentColor100: UIColor { get }
    var accentColor150: UIColor { get }
    var accentColor200: UIColor { get }
    var accentColor300: UIColor { get }
    var accentColor400: UIColor { get }
    var accentColor500: UIColor { get }
    var accentColor600: UIColor { get }
    var accentColor700: UIColor { get }
    var accentColor800: UIColor { get }

    var textColorPrimary: UIColor { get }
    var textColorSecondary: UIColor { get }
    var textColorDisabled: UIColor { get }
    var textColorNegative: UIColor { get }
    var textColorCaution: UIColor { get }
    var textColorPositive: UIColor { get }
    @available(*, deprecated, renamed: "textColorLink")
    @objc optional var tetColorLink: UIColor { get }
    var textColorLink: UIColor { get }
    var textColorWhite: UIColor { get }
    var textColorWarning: UIColor { get }

    var feedbackColorNegative: UIColor { get }
    var feedbackColorCaution: UIColor { get }
    var feedbackColorPositive: UIColor { get }
    var feedbackColorWarning: UIColor { get }
}

/**
  AndesFonts is used to create a new StyleSheet
  implementing all the necessary fonts
*/
@objc public protocol AndesFonts {
    /**
      The default font variations that you need to override
      to use your own font through all the UI components.
      By default these return the SF system font
    */
    func titleXL(color: UIColor) -> AndesFontStyle
    func titleL(color: UIColor) -> AndesFontStyle
    func titleM(color: UIColor) -> AndesFontStyle
    func titleS(color: UIColor) -> AndesFontStyle
    func titleXS(color: UIColor) -> AndesFontStyle

    func bodyL(color: UIColor) -> AndesFontStyle
    func bodyM(color: UIColor) -> AndesFontStyle
    func bodyS(color: UIColor) -> AndesFontStyle
    func bodyXS(color: UIColor) -> AndesFontStyle

    func regularSystemFont(size: CGFloat) -> UIFont
    func lightSystemFont(size: CGFloat) -> UIFont
    func mediumSystemFontOfSize(size: CGFloat) -> UIFont
    func semiboldSystemFontOfSize(size: CGFloat) -> UIFont
}

@objc public protocol AndesSecondaryColors {
    /**
      The secondary colors that you need to override
      to use your color palette through all the UI components
    */
    var secondaryA100: UIColor { get }
    var secondaryA200: UIColor { get }
    var secondaryA300: UIColor { get }
    var secondaryA400: UIColor { get }
    var secondaryA500: UIColor { get }
    var secondaryA600: UIColor { get }
    var secondaryA700: UIColor { get }
    var secondaryA800: UIColor { get }
    var secondaryA900: UIColor { get }
    var secondaryB100: UIColor { get }
    var secondaryB200: UIColor { get }
    var secondaryB300: UIColor { get }
    var secondaryB400: UIColor { get }
    var secondaryB500: UIColor { get }
    var secondaryB600: UIColor { get }
    var secondaryB700: UIColor { get }
    var secondaryB800: UIColor { get }
    var secondaryB900: UIColor { get }
    var secondaryC100: UIColor { get }
    var secondaryC200: UIColor { get }
    var secondaryC300: UIColor { get }
    var secondaryC400: UIColor { get }
    var secondaryC500: UIColor { get }
    var secondaryC600: UIColor { get }
    var secondaryC700: UIColor { get }
    var secondaryC800: UIColor { get }
    var secondaryC900: UIColor { get }
    var secondaryD100: UIColor { get }
    var secondaryD200: UIColor { get }
    var secondaryD300: UIColor { get }
    var secondaryD400: UIColor { get }
    var secondaryD500: UIColor { get }
    var secondaryD600: UIColor { get }
    var secondaryD700: UIColor { get }
    var secondaryD800: UIColor { get }
    var secondaryD900: UIColor { get }
    var secondaryE100: UIColor { get }
    var secondaryE200: UIColor { get }
    var secondaryE300: UIColor { get }
    var secondaryE400: UIColor { get }
    var secondaryE500: UIColor { get }
    var secondaryE600: UIColor { get }
    var secondaryE700: UIColor { get }
    var secondaryE800: UIColor { get }
    var secondaryE900: UIColor { get }
    var secondaryF100: UIColor { get }
    var secondaryF200: UIColor { get }
    var secondaryF300: UIColor { get }
    var secondaryF400: UIColor { get }
    var secondaryF500: UIColor { get }
    var secondaryF600: UIColor { get }
    var secondaryF700: UIColor { get }
    var secondaryF800: UIColor { get }
    var secondaryF900: UIColor { get }
    var secondaryG100: UIColor { get }
    var secondaryG200: UIColor { get }
    var secondaryG300: UIColor { get }
    var secondaryG400: UIColor { get }
    var secondaryG500: UIColor { get }
    var secondaryG600: UIColor { get }
    var secondaryG700: UIColor { get }
    var secondaryG800: UIColor { get }
    var secondaryG900: UIColor { get }
    var secondaryH100: UIColor { get }
    var secondaryH200: UIColor { get }
    var secondaryH300: UIColor { get }
    var secondaryH400: UIColor { get }
    var secondaryH500: UIColor { get }
    var secondaryH600: UIColor { get }
    var secondaryH700: UIColor { get }
    var secondaryH800: UIColor { get }
    var secondaryH900: UIColor { get }
    var secondaryI100: UIColor { get }
    var secondaryI200: UIColor { get }
    var secondaryI300: UIColor { get }
    var secondaryI400: UIColor { get }
    var secondaryI500: UIColor { get }
    var secondaryI600: UIColor { get }
    var secondaryI700: UIColor { get }
    var secondaryI800: UIColor { get }
    var secondaryI900: UIColor { get }
    var secondaryJ100: UIColor { get }
    var secondaryJ200: UIColor { get }
    var secondaryJ300: UIColor { get }
    var secondaryJ400: UIColor { get }
    var secondaryJ500: UIColor { get }
    var secondaryJ600: UIColor { get }
    var secondaryJ700: UIColor { get }
    var secondaryJ800: UIColor { get }
    var secondaryJ900: UIColor { get }
    var secondaryK100: UIColor { get }
    var secondaryK200: UIColor { get }
    var secondaryK300: UIColor { get }
    var secondaryK400: UIColor { get }
    var secondaryK500: UIColor { get }
    var secondaryK600: UIColor { get }
    var secondaryK700: UIColor { get }
    var secondaryK800: UIColor { get }
    var secondaryK900: UIColor { get }
    var secondaryL100: UIColor { get }
    var secondaryL200: UIColor { get }
    var secondaryL300: UIColor { get }
    var secondaryL400: UIColor { get }
    var secondaryL500: UIColor { get }
    var secondaryL600: UIColor { get }
    var secondaryL700: UIColor { get }
    var secondaryL800: UIColor { get }
    var secondaryL900: UIColor { get }
}
