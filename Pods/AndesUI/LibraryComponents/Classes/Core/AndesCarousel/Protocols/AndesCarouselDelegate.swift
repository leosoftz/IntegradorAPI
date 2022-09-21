//
//  AndesCarouselDelegate.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 04/02/2021.
//

import Foundation

@objc public protocol AndesCarouselDelegate {
    @objc func andesCarousel(_ carouselView: AndesCarousel, didSelectItemAt indexPath: IndexPath)
    @objc optional func andesCarousel(_ carouselView: AndesCarousel, sizeForItemAt indexPath: IndexPath) -> CGSize
    @objc optional func andesCarousel(_ carouselView: AndesCarousel, currentIndexChanged indexPath: IndexPath)
}
