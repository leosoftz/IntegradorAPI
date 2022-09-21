//
//  AndesModalViewConfig.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 12/05/22.
//

import UIKit

/// Used to define the ui of internal AndesModal views
internal struct AndesModalViewConfig {
    let options: AndesModalOptions
    let layout: AndesModalLayoutProtocol
    let textAlignment: NSTextAlignment
    let verticalAlignmet: AndesModalVerticalAlignment
    let footerView: AndesButtonGroup?
    let imageContentMode: UIView.ContentMode
    weak var bodyDelegate: AndesModalBodyViewDelegate?

    init(options: AndesModalOptions, with actions: AndesModalActions) {
        self.options = options
        switch options.type {
        case .card:
            self.layout = AndesModalLayoutCard(options: options, actions: actions)
            self.textAlignment = .center
            self.verticalAlignmet = .top

        case .fullscreen:
            self.layout = AndesModalLayoutFullScreen(options: options)
            self.textAlignment = options.imageStyle == .none ? .left : .center
            self.verticalAlignmet = options.imageStyle == .none ? .top : .middle
        }

        switch options.imageStyle {
        case .banner, .thumbnail:
            imageContentMode = .scaleAspectFill
        default:
            imageContentMode = .scaleAspectFit
        }

        let buttons = actions.buttons
        guard !buttons.isEmpty else {
            self.footerView = nil
            return
        }

        self.footerView = AndesButtonGroup(
            buttonList: buttons,
            type: .fullWidth,
            distribution: actions.distribution,
            align: .center
        )
    }
}
