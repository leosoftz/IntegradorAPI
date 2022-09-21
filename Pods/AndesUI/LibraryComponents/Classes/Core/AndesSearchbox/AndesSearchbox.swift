//
//  AndesSearchbox.swift
//  AndesUI
//
//  Created by Alvaro Hernan Orellana Villarroel on 21/05/2022.
//

import Foundation

@objc public class AndesSearchbox: UIView {
    internal var contentView: AndesSearchboxView!
    @objc public weak var delegate: AndesSearchboxDelegate?

    @objc public var placeholder = "Buscar".localized() + "..." {
        didSet {
            updateContentView()
        }
    }

    @objc public var state: AndesSearchboxState = .idle {
        didSet {
            updateContentView()
        }
    }

    @objc public var searchText: String? {
        get {
            contentView.searchText
        }
        set {
            contentView.searchText = newValue
        }
    }

    var accessibilityManager: AndesAccessibilityManager?

    override public func accessibilityActivate() -> Bool {
        return accessibilityManager?.accessibilityActivated() != nil
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @objc public init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear

        let contentView = provideContentView()
        drawContentView(with: contentView)
        accessibilityManager = AndesSearchboxAccesibilityManager(view: self)
    }

    private func provideContentView() -> AndesSearchboxView {
        let config = AndesSearchboxViewConfigFactory.provideInternalConfig(placeholder: placeholder, state: state)
        return AndesSearchboxViewDefault(withConfig: config)
    }

    private func drawContentView(with newView: AndesSearchboxView) {
        self.contentView = newView
        contentView.delegate = self
        addSubview(contentView)
        contentView.pinToSuperview()
    }

    private func updateContentView() {
        let config = AndesSearchboxViewConfigFactory.provideInternalConfig(placeholder: placeholder, state: state)
        contentView.update(withConfig: config)
        accessibilityManager?.viewUpdated()
    }

    override public func resignFirstResponder() -> Bool {
        contentView.resignFirstResponder()
    }
}

// MARK: AndesSearchboxViewDelegate
extension AndesSearchbox: AndesSearchboxViewDelegate {
    func searchboxView(_ searchboxView: AndesSearchboxView, textDidChange searchText: String) {
        delegate?.andesSearchbox(self, textDidChange: searchText)
    }

    func searchboxViewSearchButtonClicked(_ searchboxView: AndesSearchboxView) {
        delegate?.andesSearchboxSearchButtonClicked(self)
    }

    func searchboxTextDidBeginEditing(_ searchbox: AndesSearchboxView) {
        state = .focus
    }

    func searchboxTextDidEndEditing(_ searchbox: AndesSearchboxView) {
        state = .idle
    }
}

// MARK: - IB interface
public extension AndesSearchbox {
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'placeholder' instead.")
    @IBInspectable var ibPlaceholder: String {
        set(val) {
            self.placeholder = val
        }
        get {
            return self.placeholder
        }
    }

    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'state' instead.")
    @IBInspectable var ibState: String {
        set(val) {
            self.state = AndesSearchboxState.checkValidEnum(property: "IB state", key: val)
        }
        get {
            return self.state.toString()
        }
    }
}
