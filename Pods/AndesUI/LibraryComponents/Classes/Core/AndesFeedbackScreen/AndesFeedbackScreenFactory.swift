//
//  AndesFeedbackScreenFactory.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 17/08/2021.
//

import Foundation
@objc
public class AndesFeedbackScreenFactory: NSObject {
    @objc
    public static func createAndesFeedbackScreenSimple(feedbackColor: AndesFeedbackScreenColor, header: AndesFeedbackScreenHeader, body: AndesFeedbackScreenScreenBody?, actions: AndesFeedbackScreenActions) -> AndesFeedbackScreenView {
        header.thumbnail?.color = feedbackColor
        if header.thumbnail != nil {
            header.thumbnailView = AndesFeedbackScreenBadgeFactory.createThumbnailBadgeView(thumbnailInfo: header.thumbnail)
        }
        let andesFeedbackData = AndesFeedbackScreenData(type: .simple, feedbackColor: feedbackColor, header: header, body: body)

        return AndesFeedbackScreenView(data: andesFeedbackData, actions: actions)
    }

    @objc
    public static func createAndesFeedbackScreenCongrats (header: AndesFeedbackScreenHeader, body: AndesFeedbackScreenScreenBody?, actions: AndesFeedbackScreenActions) -> AndesFeedbackScreenView {
        header.thumbnail?.color = .green
        header.thumbnailView = AndesFeedbackScreenBadgeFactory.createThumbnailBadgeView(thumbnailInfo: header.thumbnail)
        let andesFeedbackData = AndesFeedbackScreenData(type: .congrats, feedbackColor: AndesFeedbackScreenColor.green, header: header, body: body)
        return AndesFeedbackScreenView(data: andesFeedbackData, actions: actions)
    }

    @objc
    public static func createAndesFeedbackScreenError(errorComponent: AndesFeedbackScreenErrorComponent, actions: AndesFeedbackScreenActions?) -> AndesFeedbackScreenView {
        let header: AndesFeedbackScreenHeader = errorComponent.getFeedbackScreeErrorData()
        header.thumbnail?.color = .gray
        header.thumbnailView = AndesFeedbackScreenBadgeFactory.createThumbnailBadgeView(thumbnailInfo: header.thumbnail)
        let andesFeedbackData = AndesFeedbackScreenData(type: .error,
                                                        feedbackColor: AndesFeedbackScreenColor.gray,
                                                        header: header,
                                                        body: nil)

        return AndesFeedbackScreenView(data: andesFeedbackData, actions: actions)
    }
}
