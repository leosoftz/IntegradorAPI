//
//  AndesCarouselViewConfigFactory.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 05/02/2021.
//

import Foundation

/**
The responsability of the factory is to provide the ViewConfig from the user specified attributes
*/
internal class AndesCarouselViewConfigFactory {
    static func provide(for carousel: AndesCarousel) -> AndesCarouselViewConfig {
        let title = carousel.title ?? String()
        let marginConfig = AndesCarouselMarginFactory.provide(carousel.margin)
        let mode = AndesCarouselModeFactory.provide(carousel.mode)
        let showPageControl = carousel.usePaginator && mode.centered
        return AndesCarouselViewConfig(title: title,
                                       margin: CGFloat(marginConfig.margin),
                                       cellSpacing: marginConfig.cellSpacing,
                                       centerScroll: mode.centered,
                                       usePaginator: showPageControl,
                                       marginMode: marginConfig.marginMode,
                                       isInfinityScroll: carousel.isInfinityScroll,
                                       isAutoScroll: carousel.isAutoScroll)
    }
}
