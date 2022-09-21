//
//  AndesTabItem.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 21/07/21.
//

import Foundation

@objc public class AndesTabItem: NSObject {
    var title: String

    @objc public init(_ title: String) {
        self.title = title
    }
}
