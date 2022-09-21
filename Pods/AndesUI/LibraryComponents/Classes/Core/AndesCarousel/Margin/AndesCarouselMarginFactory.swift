//
//  AndesCarouselMarginFactory.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 08/02/2021.
//

import Foundation

class AndesCarouselMarginFactory {
    static func provide(_ type: AndesCarouselMargin) -> AndesCarouselMarginProtocol {
        switch type {
        case .none:
            return AndesCarouselMarginNone()
        case .defaultMargin:
            return AndesCarouselMarginDefault()
        case .compactMargin:
            return AndesCarouselCompactMargin()
        }
    }
}
