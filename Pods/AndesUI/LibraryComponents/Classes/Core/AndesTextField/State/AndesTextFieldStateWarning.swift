//
//  AndesTextFieldStateWarning.swift
//  AndesUI
//
//  Created by Oscar Sierra Zuniga on 2/02/21.
//

import Foundation
struct AndesTextFieldStateWarning: AndesTextFieldStateProtocol {
    var borderColor = AndesStyleSheetManager.styleSheet.feedbackColorWarning
    var borderWidth: CGFloat = 1
    var borderDashed: Bool = false

    var labelTextColor = AndesStyleSheetManager.styleSheet.textColorWarning

    var helperColor = AndesStyleSheetManager.styleSheet.textColorWarning
    var helperIconTintColor: UIColor? = AndesStyleSheetManager.styleSheet.textColorWhite
    var helperIconName: String? = "andes_ui_feedback_error_16"
    var helperSemibold: Bool = true

    var backgroundColor = AndesStyleSheetManager.styleSheet.bgColorWhite
    var inputTextColor = AndesStyleSheetManager.styleSheet.textColorPrimary
    var editingEnabled = true

    var placeholderTextColor = AndesStyleSheetManager.styleSheet.textColorSecondary

    init(focuesd: Bool) {
        if focuesd {
            backgroundColor = AndesStyleSheetManager.styleSheet.bgColorWhite
            borderWidth = 2
        }
    }
}
