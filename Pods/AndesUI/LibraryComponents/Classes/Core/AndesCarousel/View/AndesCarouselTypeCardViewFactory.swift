//
//  AndesCarouselTypeCardViewFactory.swift
//  AndesUI
//
//  Created by Robert Bevilacqua on 03/06/2021.
//

import UIKit

class AndesCarouselTypeCardViewFactory {
    static func provide(for config: AndesCarouselViewConfig, view: AndesCarousel) -> AndesCarouselView {
        switch config.marginMode {
        case .defaultMargin:
            return AndesCarouselDefaultWidthView(withConfig: config, delegate: view)
        case .compactMargin:
            return AndesCarouselCompactView(withConfig: config, delegate: view)
        default:
            return AndesCarouselFullWidthView(withConfig: config, delegate: view)
        }
    }
}
