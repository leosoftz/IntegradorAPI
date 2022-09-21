//
//  AndesFeedbackScreenThumbnail.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 1/09/21.
//

import Foundation
@objc public class AndesFeedbackScreenThumbnail: NSObject {
    var image: UIImage?
    var color: AndesFeedbackScreenColor?
    var thumbnailType: AndesFeedbackScreenThumbnailType

    /// Thumbnail with image
    @objc public init(image: UIImage) {
        self.image = image
        self.thumbnailType = .image
    }

    /// Thumbnail with icon
    @objc public init(icon: UIImage) {
        self.image = icon
        self.thumbnailType = .icon
    }

    /// Thumbnail feedbackIcon
    @objc override public init() {
        self.image = nil
        self.thumbnailType = .iconWithoutBadge
    }
}
