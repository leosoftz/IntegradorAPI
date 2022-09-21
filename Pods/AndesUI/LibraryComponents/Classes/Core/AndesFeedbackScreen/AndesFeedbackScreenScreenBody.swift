//
//  AndesFeedbackScreenScreenBody.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 17/08/2021.
//

import Foundation
@objc
public class AndesFeedbackScreenScreenBody: NSObject {
    private(set) var aditionalView: UIView

    @objc public init(view: UIView) {
        self.aditionalView = view
    }
}
