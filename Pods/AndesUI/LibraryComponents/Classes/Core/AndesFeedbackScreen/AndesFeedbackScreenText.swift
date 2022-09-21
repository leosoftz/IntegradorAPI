//
//  AndesFeedbackScreenText.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 17/08/2021.
//

import Foundation

enum AndesFeedbackScreenTextMode {
    case normal
    case highlighted
    case overline
}

@objc
public class AndesFeedbackScreenText: NSObject {
    private(set) var title: String
    private(set) var descriptionText: String?
    private(set) var descriptionLinks: AndesBodyLinks?
    private(set) var highlighted: String?
    private(set) var overline: String?
    private(set) var errorCodeText: String?
    private(set) var mode: AndesFeedbackScreenTextMode

    @objc public init(title: String, description: String, descriptionLinks: AndesBodyLinks?, highlighted: String) {
        self.title = title
        self.descriptionText = description
        self.descriptionLinks = descriptionLinks
        self.highlighted = highlighted
        self.mode = .highlighted
    }

    @objc public init(title: String, description: String?, descriptionLinks: AndesBodyLinks?) {
        self.title = title
        self.descriptionText = description
        self.descriptionLinks = descriptionLinks
        self.mode = .normal
    }

    @objc public init(title: String, overline: String) {
        self.title = title
        self.overline = overline
        self.mode = .overline
    }

    @objc
    public init(title: String, description: String, errorCode: String? = nil) {
        self.title = title
        self.descriptionText = description
        self.errorCodeText = errorCode
        self.mode = .normal
    }
}
