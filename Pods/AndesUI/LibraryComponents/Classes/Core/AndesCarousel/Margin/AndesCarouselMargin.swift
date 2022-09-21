//
//  AndesCarouselMargin.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 04/02/2021.
//

import Foundation

/**
The AndesCarouselMargin contains the differents margins that a Carousel supports
*/
@objc public enum AndesCarouselMargin: Int, AndesEnumStringConvertible {
    case none
    case defaultMargin
    case compactMargin

    public static func keyFor(_ value: AndesCarouselMargin) -> String {
        switch value {
        case .none: return "NONE"
        case .defaultMargin: return "DEFAULT"
        case .compactMargin: return "COMPACT"
        }
    }
}
