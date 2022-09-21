//
//  AndesCarouselViewProtocol.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 23/03/2021.
//

import Foundation

@objc internal protocol AndesCarouselViewProtocol {
    func cellForRowAt(indexPath: IndexPath) -> UIView
    func numberOfRow() -> Int
    func didSelectItemAt(indexPath: IndexPath)
    func sizeForItemAt(indexPath: IndexPath) -> CGSize
    func indexNumberChanged(indexPath: IndexPath)
}
