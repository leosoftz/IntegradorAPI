//
//  AndesMoneyInfo.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 25/01/2022.
//

import Foundation

@objc
public class AndesMoneyInfo: NSObject {
    public private(set) var attributedMoney: NSAttributedString
    public private(set) var a11yText: String

    @objc
    init(attributedMoney: NSAttributedString, a11yText: String) {
        self.attributedMoney = attributedMoney
        self.a11yText = a11yText
    }
}
