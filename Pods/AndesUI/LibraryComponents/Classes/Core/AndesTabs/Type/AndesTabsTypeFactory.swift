//
//  
//  AndesTabsTypeFactory.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 21/07/21.
//
//

import Foundation

class AndesTabsTypeFactory {
    static func provide(_ type: AndesTabsType) -> AndesTabsTypeProtocol {
        switch type {
        case .fullWidth:
            return AndesTabsFullWidthType()
        case .leftAlign:
            return AndesTabsLeftAlignType()
        }
    }
}
