//
//  AndesTextFieldViewConfigFactory.swift
//  AndesUI
//
//  Created by Martin Damico on 11/03/2020.
//

import Foundation
internal class AndesTextFieldViewConfigFactory {
    static func provideInternalConfig(from textField: AndesTextField) -> AndesTextFieldViewConfig {
        let stateStyle = AndesTextFieldStateFactory.getState(textField.state, isEditing: textField.isEditing)
        let paddings = AndesTextInputPaddingFactory.providePaddingForField(state: textField.state)

        let config = AndesTextFieldViewConfig(labelText: textField.label,
                                              helperText: textField.helper,
                                              helperLinks: textField.helperLinks,
                                              helperBolds: textField.helperBolds,
                                              counter: textField.counter,
                                              placeholderText: textField.placeholder,
                                              stateStyle: stateStyle,
                                              leftViewComponent: textField.leftContent,
                                              rightViewComponent: textField.rightContent,
                                              inputTraits: textField.inputTraits,
                                              paddings: paddings,
                                              isSecureTextEntry: textField.isSecureTextEntry,
                                              accessibilityActivated: textField.accessibilityManager?.accessibilityActivated)
        return config
    }

    static func provideInternalConfig(from textArea: AndesTextArea) -> AndesTextFieldViewConfig {
        let stateStyle = AndesTextFieldStateFactory.getState(textArea.state, isEditing: textArea.isEditing)
        let paddings = AndesTextInputPaddingFactory.providePaddingForArea(state: textArea.state)

        let config = AndesTextFieldViewConfig(labelText: textArea.label,
                                              helperText: textArea.helper,
                                              helperLinks: textArea.helperLinks,
                                              helperBolds: textArea.helperBolds,
                                              counter: textArea.counter,
                                              placeholderText: textArea.placeholder,
                                              stateStyle: stateStyle,
                                              leftViewComponent: nil,
                                              rightViewComponent: nil,
                                              inputTraits: textArea.inputTraits,
                                              maxLines: textArea.maxLines,
                                              paddings: paddings,
                                              isSecureTextEntry: false,
                                              accessibilityActivated: textArea.accessibilityManager?.accessibilityActivated)

        return config
    }
}
