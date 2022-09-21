//
//  AndesCarouselModeFactory.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 29/03/2021.
//

import Foundation

class AndesCarouselModeFactory {
    static func provide(_ type: AndesCarouselMode) -> AndesCarouselModeProtocol {
        switch type {
        case .free:
            return AndesCarouselModeFree()
        case .snapped:
            return AndesCarouselModeSnapped()
        }
    }
}
