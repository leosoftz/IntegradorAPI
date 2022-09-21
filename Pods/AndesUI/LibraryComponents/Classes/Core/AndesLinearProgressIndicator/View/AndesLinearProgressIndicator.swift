//
//  AndesLinearProgressDeterminate.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal.
//

import Foundation

internal protocol AndesLinearProgressIndicator: UIView {
    var size: AndesLinearProgressIndicatorSize { get set }
    var indicatorTint: UIColor { get set }
    var trackTint: UIColor { get set }

    func setup(config: AndesLinearProgressIndicatorViewConfig)
    func updateView(config: AndesLinearProgressIndicatorViewConfig)
    func createConfig() -> AndesLinearProgressIndicatorViewConfig
}
