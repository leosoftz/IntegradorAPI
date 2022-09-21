//
//  AndesFeedbackScreenData.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 25/08/2021.
//

class AndesFeedbackScreenData: NSObject {
    let type: AndesFeedbackScreenType
    let feedbackColor: AndesFeedbackScreenColor
    let header: AndesFeedbackScreenHeader
    let body: AndesFeedbackScreenScreenBody?

    init(type: AndesFeedbackScreenType, feedbackColor: AndesFeedbackScreenColor, header: AndesFeedbackScreenHeader, body: AndesFeedbackScreenScreenBody? ) {
        self.type = type
        self.feedbackColor = feedbackColor
        self.header = header
        self.body = body
    }
}
