//
//  AndesModalPage.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 12/05/22.
//
import UIKit

/// Information about content of modal
///
/// Add rich text to a modal such as link and bold text
///
///     AndesModalContent(
///         image: UIImage(named: "product"),
///         title: "Lorem ipsum"
///         body: AndesModalAttributedString(text: "This is a ")
///                 .append(text: "Important Information", isBold: true)
///                 .append(link: " Clik here")
///     )
@objc
public class AndesModalContent: NSObject {
    internal let image: AndesModalImage?
    internal let title: AndesModalAttributedString
    internal let body: AndesModalAttributedString?

    @objc
    public init(image: UIImage? = nil, title: AndesModalAttributedString, body: AndesModalAttributedString? = nil) {
        if let image = image {
            self.image = AndesModalImage(image)
        } else {
            self.image = nil
        }
        self.title = title
        self.body = body
    }

    @objc(initWith:title:body:)
    public init(image: AndesModalImage, title: AndesModalAttributedString, body: AndesModalAttributedString? = nil) {
        self.image = image
        self.title = title
        self.body = body
    }

    public init(image: UIImage? = nil, title: String, body: String? = nil) {
        if let image = image {
            self.image = AndesModalImage(image)
        } else {
            self.image = nil
        }
        self.title = AndesModalAttributedString(text: title)
        if let body = body {
            self.body = AndesModalAttributedString(text: body)
        } else {
            self.body = nil
        }
    }

    public init(image: AndesModalImage, title: String, body: String? = nil) {
        self.image = nil
        self.title = AndesModalAttributedString(text: title)
        if let body = body {
            self.body = AndesModalAttributedString(text: body)
        } else {
            self.body = nil
        }
    }
}
