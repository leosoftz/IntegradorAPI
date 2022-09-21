//
//  AndesBodyBolds.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 26/10/2021.
//

import Foundation

@objc
public class AndesBodyBolds: NSObject {
    var bolds: [AndesBodyBold]

    public init(bolds: [AndesBodyBold]) {
        self.bolds = bolds
    }

    @objc public init(bolds: NSArray) {
        self.bolds = bolds as? [AndesBodyBold] ?? []
    }
}
