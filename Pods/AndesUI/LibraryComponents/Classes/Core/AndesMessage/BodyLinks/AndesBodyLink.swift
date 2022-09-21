//
//  AndesBodyLink.swift
//  AndesUI
//
//  Created by Marcelo Agustin Gil on 27/07/2020.
//
@objc
public class AndesBodyLink: NSObject {
    var startIndex: Int
    var endIndex: Int

    @objc public init(startIndex: Int, endIndex: Int) {
        self.startIndex = startIndex
        self.endIndex = endIndex
    }

    func isValidRange(_ text: NSAttributedString) -> Bool {
        return (startIndex >= 0 && endIndex >= 0 && startIndex <= endIndex && endIndex <= text.length)
    }
}
