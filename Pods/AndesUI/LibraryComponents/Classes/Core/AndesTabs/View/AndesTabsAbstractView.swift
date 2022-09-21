//
//  
//  AndesTabsAbstractView.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 21/07/21.
//
//

import UIKit

class AndesTabsAbstractView: UIView, AndesTabsView {
    @IBOutlet var componentView: UIView!
    @IBOutlet var bottomTabsIndicator: UIView!
    @IBOutlet var tabsContainer: UIStackView!
    @IBOutlet var bottomIndicatorLine: UIView!
    @IBOutlet var widthConstraint: NSLayoutConstraint!

    var config: AndesTabsViewConfig
    weak var delegate: AndesTabsDelegate?
    var tabsViews: [AndesTabItemView] = []
    var currentSelection: Int = 0
    let tabIndicator: UIView = UIView()
    var dispatchQueue: AndesDispatchQueueType?

    init(withConfig config: AndesTabsViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    override func layoutSublayers(of layer: CALayer) {
          super.layoutSublayers(of: layer)
          self.updateSelected(self.tabsViews[currentSelection], index: currentSelection, animated: false)
    }

    required init?(coder: NSCoder) {
        config = AndesTabsViewConfig()
        self.dispatchQueue = DispatchQueue.main
        super.init(coder: coder)
        setup()
    }

    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    func update(withConfig config: AndesTabsViewConfig) {
        self.config = config
        dispatchQueue = config.dispatchQueue
        updateView()
    }

    func pinXibViewToSelf() {
        addSubview(componentView)
        componentView.translatesAutoresizingMaskIntoConstraints = false
        componentView.pinToSuperview()
    }

    func setup() {
        loadNib()
        translatesAutoresizingMaskIntoConstraints = false
        pinXibViewToSelf()
        updateView()
    }

    func updateView() {
        createTabsIfNeeded()
        setupTabsContainer()
    }

    func updateSelectedTab(at index: Int, animated: Bool) {
        dispatchQueue?.async { [weak self] in
            guard let self = self else { return }
            self.updateSelected(self.tabsViews[index], index: index, animated: animated)
        }
    }

    func resetTabsElements() {
        tabsContainer.arrangedSubviews.forEach { $0.removeFromSuperview() }
        currentSelection = 0
        updateSelectedTab(at: 0, animated: false)
    }

    private func createTabsIfNeeded() {
        if tabsContainer.arrangedSubviews.count != config.tabsList.count {
            setupTabsViews()
        }
    }

    private func setupTabsContainer() {
        widthConstraint.isActive = config.fullWidthTab
        tabsContainer.distribution = config.distribution
        componentView.layoutIfNeeded()
        currentSelection = 0
        updateSelectedTab(at: 0, animated: false)
    }

    private func setupTabsViews() {
        tabsViews = config.tabsList.map { [unowned self] tabItem -> AndesTabItemView in
            createTabView(with: tabItem)
        }

        tabsViews.enumerated().forEach { [unowned self] tabView in
            tabsContainer.addArrangedSubview(tabView.element)
            tabView.element.tabSelected = { [unowned self] in
                updateSelected(tabView.element, index: tabView.offset, animated: true)
                delegate?.didSelectTab(at: tabView.offset)
            }
        }

        componentView.backgroundColor = config.style.backgroundColor
        bottomTabsIndicator.addSubview(tabIndicator)
        bottomIndicatorLine.backgroundColor = config.style.bottomIndicatorLineColor
        tabIndicator.backgroundColor = config.style.accentColor
        updateIndicator(animated: false)
    }

    private func createTabView(with tabItem: AndesTabItem) -> AndesTabItemView {
        let tabView = AndesTabItemView()
        tabView.tabTitle.text = tabItem.title
        tabView.tabTitle.setAndesStyle(style: config.style.andesStyle)
        tabView.tabTitle.lineBreakMode = config.style.lineBreakMode
        tabView.tabTitle.textAlignment = config.style.textAlignment
        return tabView
    }

    private func updateSelected(_ tabView: AndesTabItemView, index: Int, animated: Bool) {
        tabsViews[currentSelection].tabTitle.textColor = config.style.textColor
        currentSelection = index
        updateIndicator(animated: animated)
    }

    private func updateIndicator(animated: Bool ) {
        guard tabsViews.count > 0 else { return }
        if animated {
            UIView.animate(withDuration: 0.3, delay: .zero, options: [.curveEaseIn]) {[unowned self] in
                updateCurrentTab()
            }
        } else {
            updateCurrentTab()
        }
    }

    private func updateCurrentTab() {
        componentView.layoutIfNeeded()

        tabIndicator.frame = CGRect(x: horizontalPositionForIndicator(),
                                    y: bottomTabsIndicator.bounds.origin.y,
                                    width: horizontalWidthForIndicator(),
                                    height: bottomTabsIndicator.bounds.height)

        setupIndicatorCorners()

        tabsViews[currentSelection].tabTitle.textColor = config.style.accentColor
    }

    private func horizontalPositionForIndicator() -> CGFloat {
        tabsViews[currentSelection].frame.origin.x +
            (config.fullWidthTab ? .zero : tabsViews[currentSelection].tabTitle.frame.origin.x )
    }

    private func horizontalWidthForIndicator() -> CGFloat {
        config.fullWidthTab ? tabsViews[currentSelection].frame.width : tabsViews[currentSelection].tabTitle.frame.width
    }

    private func setupIndicatorCorners() {
        var fullWidthRoundCorners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        if currentSelection == tabsViews.count - 1 {
            fullWidthRoundCorners = [.layerMinXMinYCorner]
        }
        if currentSelection == 0 {
            fullWidthRoundCorners = [.layerMaxXMinYCorner]
        }
        let roundCorners: CACornerMask = config.fullWidthTab ? fullWidthRoundCorners : [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabIndicator.setCornerRadius(cornerRadius: config.cornerRadius, roundedCorners: roundCorners)
    }
}
