//
//  AndesBodyBold.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 26/10/2021.
//

import Foundation

@objc
public class AndesBodyBold: NSObject {
    var startIndex: Int
    var endIndex: Int

    @objc public init(startIndex: Int, endIndex: Int) {
        self.startIndex = startIndex
        self.endIndex = endIndex
    }

    @objc public init(range: NSRange) {
        self.startIndex = range.lowerBound
        self.endIndex = range.upperBound
    }

    func isValidRange(_ text: NSAttributedString) -> Bool {
        return (startIndex >= 0 && endIndex >= 0 && startIndex <= endIndex && endIndex <= text.length)
    }
}
