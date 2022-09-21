//
//  Bullet.swift
//  AndesUI
//
//  Created by Martin Ezequiel Becerra on 2/25/21.
//

import Foundation

/// Class to create Body Bullets for an AndesMessage
@objc public final class AndesBullet: NSObject {
    let text: String
    let bodyLinks: AndesBodyLinks?

    public init(text: String, bodyLink: AndesBodyLinks) {
        self.text = text
        self.bodyLinks = bodyLink
    }

    @objc public init(text: String) {
        self.text = text
        self.bodyLinks = nil
    }
}
