//
//  AndesCarouselMode.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 29/03/2021.
//

import Foundation

/**
The AndesCarouselMode contains the differents modes that a Carousel supports
*/
@objc public enum AndesCarouselMode: Int, AndesEnumStringConvertible {
    case free
    case snapped

    public static func keyFor(_ value: AndesCarouselMode) -> String {
        switch value {
        case .free: return "FREE"
        case .snapped: return "SNAPPED"
        }
    }
}
