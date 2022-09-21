//
//  AndesFeedbackScreenHeader.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 12/08/2021.
//

import UIKit

@objc
public class AndesFeedbackScreenHeader: NSObject {
    private(set) var feedbackText: AndesFeedbackScreenText
    private(set) var thumbnail: AndesFeedbackScreenThumbnail?
    var thumbnailView: AndesThumbnailBadge?
    private(set) var imageView: UIImage?
    private(set) var sizeIllustration: AndesFeedbackScreenIllustrationType?

    @objc
    public init(feedbackText: AndesFeedbackScreenText, thumbnailInfo: AndesFeedbackScreenThumbnail) {
        self.feedbackText = feedbackText
        self.thumbnail = thumbnailInfo
    }

    @objc
    public init(feedbackText: AndesFeedbackScreenText, imageView: UIImage, sizeIllustration: AndesFeedbackScreenIllustrationType = .medium) {
        self.feedbackText = feedbackText
        self.imageView = imageView
        self.sizeIllustration = sizeIllustration
    }
}
