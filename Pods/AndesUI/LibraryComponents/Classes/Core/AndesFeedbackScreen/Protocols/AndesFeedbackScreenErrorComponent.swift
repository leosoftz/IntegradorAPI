//
//  AndesFeedbackScreeErrorComponent.swift
//  AndesUI
//
//  Created by Juan Agustin Aguade Abelenda on 7/3/22.
//

import Foundation

@objc
public protocol AndesFeedbackScreenErrorComponent: AndesErrorComponent {
    /**
     * Return data to build the feedback screen.
     */
    func getFeedbackScreeErrorData() -> AndesFeedbackScreenHeader
}
