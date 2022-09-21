//
//  
//  AndesSwitchViewConfig.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 21/06/21.
//
//

import Foundation
import UIKit

/// used to define the ui of internal AndesSwitch views
internal struct AndesSwitchViewConfig {
    var type: AndesSwitchTypeProtocol = AndesSwitchTypeEnabled()
    var status: AndesSwitchStatus = .unchecked
    var align: AndesSwitchAlign = .right
    var text: String = ""
    var titleNumberOfLines: Int = 0
    var isOn: Bool = false

    internal init(type: AndesSwitchTypeProtocol = AndesSwitchTypeEnabled(), status: AndesSwitchStatus = .unchecked, align: AndesSwitchAlign = .right, text: String = "", titleNumberOfLines: Int = 0, isOn: Bool = false) {
        self.type = type
        self.status = status
        self.align = align
        self.text = text
        self.titleNumberOfLines = titleNumberOfLines
        self.isOn = isOn
    }
}
