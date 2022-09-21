//
//  AndesSearchboxStateFactory.swift
//  AndesUI
//
//  Created by Alvaro Hernan Orellana Villarroel on 31/05/2022.
//

import Foundation

class AndesSearchboxStateFactory {
    static func provide(_ state: AndesSearchboxState) -> AndesSearchboxStateProtocol {
        switch state {
        case .idle:
            return AndesSearchboxStateIdle()
        case .focus:
            return AndesSearchboxStateFocus()
        }
    }
}
