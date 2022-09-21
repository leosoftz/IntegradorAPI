//
//  AndesCarouselDataSource.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 23/03/2021.
//

import Foundation

@objc public protocol AndesCarouselDataSource {
    @objc func andesCarousel(_ carouselView: AndesCarousel, cellForRowAt indexPath: IndexPath) -> UIView
    @objc func getDataSetSize(_ carouselView: AndesCarousel) -> Int
}
