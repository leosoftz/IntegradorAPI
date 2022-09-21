//
//  
//  AndesRadioButtonGroupTypeFactory.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 10/06/21.
//
//

import Foundation

class AndesRadioButtonGroupTypeFactory {
    static func provide(_ type: AndesRadioButtonGroupDistribution) -> AndesRadioButtonGroupTypeProtocol {
        switch type {
        case .horizontal:
            return AndesRadioButtonGroupTypeHorizontal()
        case .vertical:
            return AndesRadioButtonGroupTypeVertical()
        }
    }
}
