//
//  AndesSwitchTypeFactory.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 23/06/21.
//

import Foundation

class AndesSwitchTypeFactory {
    static func provide(_ type: AndesSwitchType) -> AndesSwitchTypeProtocol {
        switch type {
        case .enable:
            return AndesSwitchTypeEnabled()
        case .disable:
            return AndesSwitchTypeDisabled()
        }
    }
}
