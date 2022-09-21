//
//  AndesLinearProgressIndicatorViewConfig.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal.
//

import Foundation

/// used to define the ui of internal AndesLinearProgressIndicator views
internal struct AndesLinearProgressIndicatorViewConfig {
    var indicatorTint: UIColor?
    var trackTint: UIColor?
    var isSplit: Bool?
    var numberOfSteps: Int?
    var size: AndesLinearProgressIndicatorSizeProtocol?

    init () {}

    init(
        indicatorTint: UIColor?,
        trackTint: UIColor?,
        isSplit: Bool?,
        numberOfSteps: Int?,
        size: AndesLinearProgressIndicatorSizeProtocol?) {
        self.indicatorTint = indicatorTint
        self.trackTint = trackTint
        self.isSplit = isSplit
        self.numberOfSteps = numberOfSteps
        self.size = size
    }
}
