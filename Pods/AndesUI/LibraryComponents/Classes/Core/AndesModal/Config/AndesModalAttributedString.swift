//
//  AndesModalAttributedString.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 1/06/22.
//

import Foundation
/// Provide rich text for a modal, bold text and links.
///
///     AndesModalAttributedString(text: "This is a ")
///         .append(text: "Important Information", isBold: true)
///         .append(link: " Clik here")
@objc
public class AndesModalAttributedString: NSObject, ExpressibleByStringLiteral {
    private typealias LinkListener = (_ index: Int) -> Void

    private struct Segment {
        let text: String
        let isBold: Bool
        let isLink: Bool
    }

    private var segments: [Segment] = []
    private var type: AndesLabelType = .body
    private var bodySize: AndesLabelBodySize = .bodyXS
    private var titleSize: AndesLabelTitleSize = .titleXS

    @objc
    public init(text: String? = nil) {
        super.init()
        if let value = text {
            segments.append(Segment(text: value, isBold: false, isLink: false))
        }
    }

    @objc
    public required init(stringLiteral value: String) {
        segments.append(Segment(text: value, isBold: false, isLink: false))
    }

    @objc
    @discardableResult
    public func append(text: String, isBold: Bool = false) -> Self {
        segments.append(Segment(text: text, isBold: isBold, isLink: false))
        return self
    }

    @objc
    @discardableResult
    public func append(link: String) -> Self {
        segments.append(Segment(text: link, isBold: false, isLink: true))
        return self
    }

    internal func with(type: AndesLabelType, size: AndesLabelTitleSize) -> Self {
        self.type = type
        titleSize = size
        return self
    }

    internal func with(type: AndesLabelType, size: AndesLabelBodySize) -> Self {
        self.type = type
        bodySize = size
        return self
    }

    @discardableResult
    internal func apply(to label: AndesLabel, listener: @escaping (_ index: Int) -> Void) -> AndesLabel {
        let bodyBolds = AndesBodyBolds(bolds: [])
        let bodyLinks = AndesBodyLinks(links: [], listener: listener)

        let text = NSMutableString()
        for segment in segments {
            if segment.isBold {
                bodyBolds.bolds.append(AndesBodyBold(startIndex: text.length, endIndex: text.length + segment.text.count))
            }

            if segment.isLink {
                bodyLinks.links.append(AndesBodyLink(startIndex: text.length, endIndex: text.length + segment.text.count))
            }
            text.append(segment.text)
        }

        label.text = text.description

        switch type {
        case .title:
            let title = AndesLabelTitleConfig(titleSize: titleSize, andesColor: .primary, bodyLinks: bodyLinks, isLinkColorInverted: false)
            label.setStyleAsTitle(titleConfig: title)
        case .body:
            let body = AndesLabelBodyConfig(bodySize: bodySize, andesColor: .primary, bodyLinks: bodyLinks, bodyBolds: bodyBolds)
            label.setStyleAsBody(bodyConfig: body)
        }

        return label
    }
}
