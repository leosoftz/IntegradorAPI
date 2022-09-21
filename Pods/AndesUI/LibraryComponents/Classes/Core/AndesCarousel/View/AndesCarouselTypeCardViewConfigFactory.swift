//
//  AndesCarouselTypeCardViewConfigFactory.swift
//  AndesUI
//
//  Created by Robert Bevilacqua on 03/06/2021.
//

import UIKit

class AndesCarouselTypeCardViewConfigFactory {
    static func getItemSize(with contentView: UIView, config: AndesCarouselViewConfig, indexPath: IndexPath) -> CGSize {
        let minimunViewMargin: CGFloat = 10
        var reduceHeight: CGFloat = minimunViewMargin * 2
        if config.title.isEmpty, config.usePaginator {
            reduceHeight += 5
        }
        let width = contentView.frame.width - config.margin * 2
        return CGSize(width: width, height: contentView.frame.height - reduceHeight)
    }

    static func getContentInset(with config: AndesCarouselViewConfig) -> UIEdgeInsets {
        let topConstraint: CGFloat = config.usePaginator || !config.title.isEmpty ? config.margin : 0
        return UIEdgeInsets(top: -topConstraint, left: config.margin, bottom: 0, right: config.margin)
    }
}
