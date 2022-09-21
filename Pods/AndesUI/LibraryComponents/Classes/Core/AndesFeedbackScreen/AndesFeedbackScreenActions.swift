//
//  AndesFeedbackScreenActions.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 02/09/2021.
//

@objc public class AndesFeedbackScreenActions: NSObject {
    let actionButton: AndesFeedbackScreenButton?
    let buttonGroup: AndesButtonGroup?
    let closeButtonCallback:  (() -> Void)?

    @objc public init(actionButton: AndesFeedbackScreenButton, closeButtonCallback: (() -> Void )?  ) {
        self.buttonGroup = nil
        self.actionButton = actionButton
        self.closeButtonCallback = closeButtonCallback
    }

    @objc
    public init(buttonGroup: AndesButtonGroup, closeButtonCallback: (() -> Void )?  ) {
        self.actionButton = nil
        self.buttonGroup = buttonGroup
        self.closeButtonCallback = closeButtonCallback
    }

    @objc public init(closeButtonCallback: @escaping (() -> Void )) {
        self.actionButton = nil
        self.buttonGroup = nil
        self.closeButtonCallback = closeButtonCallback
    }
}
