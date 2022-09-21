//
//  AndesTextFieldComponentCheckbox.swift
//  AndesUI
//
//  Created by Israel Loredo on 29/9/21.
//

import Foundation
@objc
public class AndesTextFieldComponentCheckbox: NSObject, AndesTextFieldRightComponent {
    public private(set) var visibility: AndesTextFieldComponentVisibility = .always
    public private(set) var reloadPolicy: AndesTextFieldComponentReloadPolicy = .onlyOneTime

    @objc public private(set) var text: String?
    @objc public private(set) var status: AndesCheckboxStatus
    @objc public private(set) weak var delegate: AndesTextField?

    @objc
    public init(with text: String? = nil, status: AndesCheckboxStatus, delegate: AndesTextField) {
        self.delegate = delegate
        self.text = text
        self.status = status
    }

    @objc
    public convenience init(with text: String? = nil, delegate: AndesTextField) {
        self.init(with: text, status: .unselected, delegate: delegate)
    }
}
