//
//  AndesCarouselViewConfig.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 05/02/2021.
//

import Foundation

/**
The AndesCarouselViewConfig contains the differents customizable attributes of the view
*/
internal struct AndesCarouselViewConfig {
    private(set) var title: String = ""
    private(set) var margin: CGFloat = 0.0
    private(set) var cellSpacing: CGFloat = 0.0
    private(set) var centerScroll: Bool = false
    private(set) var usePaginator: Bool = false
    private(set) var marginMode: AndesCarouselMargin = .compactMargin
    private(set) var isInfinityScroll: Bool = false
    private(set) var isAutoScroll: Bool = false
    private(set) var autoScrollSpeed: TimeInterval = 3.0
}
