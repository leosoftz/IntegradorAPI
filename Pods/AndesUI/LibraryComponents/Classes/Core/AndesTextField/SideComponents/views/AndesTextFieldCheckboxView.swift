//
//  AndesTextFieldCheckboxView.swift
//  AndesUI
//
//  Created by Israel Loredo on 29/9/21.
//

import Foundation

class AndesTextFieldCheckboxView: UIView {
    private var text: String?
    private var status: AndesCheckboxStatus = .unselected
    private weak var delegate: AndesTextField?

    init(with text: String?, status: AndesCheckboxStatus, delegate: AndesTextField?) {
        super.init(frame: .zero)
        self.delegate = delegate
        self.text = text
        self.status = status
        self.setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp() {
        let checkbox = AndesCheckbox(type: .idle, align: .right, status: status, title: text)
        checkbox.context = .textField
        checkbox.setCheckboxDidTapped(callback: self.onTap(checkbox:))
        self.addSubview(checkbox)
        checkbox.autoPinEdge(toSuperviewEdge: .right, withInset: 12)
        checkbox.autoAlignAxis(toSuperviewAxis: .horizontal)
        checkbox.autoPinEdge(toSuperviewEdge: .left)
    }

    internal func onTap(checkbox: AndesCheckbox) {
        delegate?.onTapCheckbox(with: checkbox.status)
    }
}
