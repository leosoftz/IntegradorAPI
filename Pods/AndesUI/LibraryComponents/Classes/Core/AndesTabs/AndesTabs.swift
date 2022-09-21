//
//  
//  AndesTabs.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 21/07/21.
//
//

import Foundation

@objc public class AndesTabs: UIView, AndesAccessibleView {
    var contentView: AndesTabsView!
    var dispatchQueue: AndesDispatchQueueType = DispatchQueue.main {
        didSet {
            updateContentView()
        }
    }

    @objc public var tabs: [AndesTabItem] = [] {
        didSet {
            validateMaxTabs()
            contentView.resetTabsElements()
            updateContentView()
        }
    }

    @objc public private(set) var selectedTabPosition: Int = 0

    @objc public var type: AndesTabsType = .fullWidth {
        didSet {
            validateMaxTabs()
            contentView.resetTabsElements()
            updateContentView()
        }
    }

    @objc public var onTabItemChange: ((Int, AndesTabs) -> Void)?

    var accessibilityManager: AndesAccessibilityManager?

    private let maxFullWidthTabs: Int = 5

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

    @objc public init(type: AndesTabsType, tabs: [AndesTabItem]) {
        super.init(frame: .zero)
        self.type = type
        self.tabs = tabs
        setup()
    }

    @objc public func selectTab(at position: Int, animated: Bool) throws {
        guard position < tabs.count, position >= .zero else {
            throw AndesTabsError.tabNotFound
        }
        selectedTabPosition = position
        contentView.updateSelectedTab(at: position, animated: animated)
        accessibilityManager?.viewUpdated()
        onTabItemChange?(position, self)
    }

    private func validateMaxTabs() {
        if type == .fullWidth, tabs.count > maxFullWidthTabs {
            fatalError("The max number of tabs for fullWidth type is 5")
        }
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        drawContentView(with: provideView())
        contentView.delegate = self
        accessibilityManager = AndesTabsAccessibilityManager(view: self)
    }

    private func drawContentView(with newView: AndesTabsView) {
        self.contentView = newView
        addSubview(contentView)
        contentView.pinToSuperview()
    }

    private func updateContentView() {
        let config = AndesTabsViewConfigFactory.provideInternalConfig(andesTabs: self)
        contentView.update(withConfig: config)
        accessibilityManager?.viewUpdated()
    }

    private func provideView() -> AndesTabsView {
        let config = AndesTabsViewConfigFactory.provideInternalConfig(andesTabs: self)
        return AndesTabsViewDefault(withConfig: config)
    }
}

// MARK: - IB interface
public extension AndesTabs {
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'type' instead.")
    @IBInspectable var ibType: String {
        set(val) {
            self.type = AndesTabsType.checkValidEnum(property: "IB type", key: val)
        }
        get {
            return self.type.toString()
        }
    }
}

extension AndesTabs: AndesTabsDelegate {
    func didSelectTab(at index: Int) {
        selectedTabPosition = index
        accessibilityManager?.viewUpdated()
        onTabItemChange?(index, self)
    }
}
