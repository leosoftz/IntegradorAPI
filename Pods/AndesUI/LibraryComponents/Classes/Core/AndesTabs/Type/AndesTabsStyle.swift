//
//  AndesTabsStyle.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 22/07/21.
//

import Foundation

struct AndesTabsStyle {
    let accentColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor
    let textColor: UIColor = AndesStyleSheetManager.styleSheet.textColorPrimary
    let andesStyle: AndesFontStyle = AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary, font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: 14), lineSpacing: 1.25)
    let backgroundColor: UIColor = AndesStyleSheetManager.styleSheet.bgColorWhite
    let bottomIndicatorLineColor: UIColor = UIColor.Andes.gray100
    let lineBreakMode: NSLineBreakMode = .byTruncatingTail
    let textAlignment: NSTextAlignment = .center
}
