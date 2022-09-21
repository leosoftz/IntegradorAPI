//
//  AndesSnackbarConfigFactory.swift
//  AndesUI
//
//  Created by Samuel Sainz on 6/15/20.
//

import Foundation

class AndesSnackbarViewConfigFactory {
    static func provideInternalConfig(from snackbar: AndesSnackbar) -> AndesSnackbarViewConfig {
        let hasAction: Bool = has(action: snackbar.action)
        let hasErrorCode: Bool = has(errorCode: snackbar.errorCode)

        // This returns the correct snackbar config for each case
        if hasAction && hasErrorCode {
            return getSnackbarViewConfigForActionWithError(snackbar: snackbar)
        } else if hasAction {
            return getSnackbarViewConfigForAction(snackbar: snackbar)
        } else if hasErrorCode {
            return getSnackbarViewConfigWithError(snackbar: snackbar)
        }

        return getSnackbarVieConfig(snackbar: snackbar)
    }
}

extension AndesSnackbarViewConfigFactory {
    // Return the snackbar configuration in case it has an Action AND an Error Code
    private static func getSnackbarViewConfigForActionWithError(snackbar: AndesSnackbar) -> AndesSnackbarViewConfig {
        let text = snackbar.text
        let bgColor = snackbar.type.toColor()
        guard let actionText = snackbar.action?.text else { return AndesSnackbarViewConfig() }
        let errorCode = snackbar.errorCode
        let actionConfig = AndesButtonViewConfigFactory.provide(hierarchy: AndesSnackbarButtonHierarchy(),
                                                                size: AndesSnackbarButtonSize(),
                                                                text: actionText, icon: nil)

        return AndesSnackbarViewConfig(text: text,
                                       backgroundColor: bgColor,
                                       actionConfig: actionConfig,
                                       errorCode: errorCode)
    }

    // Return the snackbar configuration in case it has an Error Code
    private static func getSnackbarViewConfigWithError(snackbar: AndesSnackbar) -> AndesSnackbarViewConfig {
        let text = snackbar.text
        let bgColor = snackbar.type.toColor()
        let errorCode = snackbar.errorCode

        return AndesSnackbarViewConfig(text: text, backgroundColor: bgColor, errorCode: errorCode)
    }

    // Return the snackbar configuration in the default case -without action nor error code-
    private static func getSnackbarVieConfig(snackbar: AndesSnackbar) -> AndesSnackbarViewConfig {
        let text = snackbar.text
        let bgColor = snackbar.type.toColor()

        return AndesSnackbarViewConfig(text: text, backgroundColor: bgColor)
    }

    // Return the Snackbar configuration in case it has sAction
    private static func getSnackbarViewConfigForAction(snackbar: AndesSnackbar) -> AndesSnackbarViewConfig {
        let text = snackbar.text
        let bgColor = snackbar.type.toColor()
        guard let actionText = snackbar.action?.text else { return AndesSnackbarViewConfig() }
        let actionConfig = AndesButtonViewConfigFactory.provide(hierarchy: AndesSnackbarButtonHierarchy(),
                                                                size: AndesSnackbarButtonSize(),
                                                                text: actionText,
                                                                icon: nil)

        return AndesSnackbarViewConfig(text: text, backgroundColor: bgColor, actionConfig: actionConfig)
    }

    // Checks if the snackbar has an action
    private static func has(action: AndesSnackbarAction?) -> Bool {
        return  action != nil
    }
    // Checks if the snackbar has an error code
    private static func has(errorCode: String?) -> Bool {
        return errorCode != nil
    }
}
