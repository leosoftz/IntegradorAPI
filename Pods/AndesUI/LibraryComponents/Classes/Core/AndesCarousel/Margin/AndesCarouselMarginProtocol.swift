//
//  AndesCarouselMarginProtocol.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 08/02/2021.
//

import Foundation

internal protocol AndesCarouselMarginProtocol {
    var margin: CGFloat { get }
    var cellSpacing: CGFloat { get }
    var marginMode: AndesCarouselMargin { get }
}
