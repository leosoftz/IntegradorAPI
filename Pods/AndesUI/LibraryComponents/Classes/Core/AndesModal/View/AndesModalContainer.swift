//
//  AndesModalVC.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 13/05/22.
//

import UIKit

internal class AndesModalContainer: UIViewController, AndesModal {
    public var currentPage: Int = 0
    private let numberofPages: Int
    internal var animateAppear: Bool = true
    private let primaryButton: AndesButton?
    private let allowsCloseButton: Bool
    internal let modalView: AndesModalView
    public weak var delegate: AndesModalDelegate?

    required init(for options: AndesModalOptions, with actions: AndesModalActions = AndesModalActions()) {
        self.allowsCloseButton = options.allowsCloseButton
        self.modalView = AndesModalContainer.provideView(for: options, with: actions)
        self.primaryButton = actions.buttons.first { $0.hierarchy == .loud }
        self.numberofPages = options.pages.count
        super.init(nibName: nil, bundle: nil)
        self.setup(for: options.type, with: modalView)
        self.setupPrimaryButton(options.isCarousel)
    }

    required init(for options: AndeModalCustomViewOptions, with actions: AndesModalActions = AndesModalActions()) {
        self.allowsCloseButton = options.allowsCloseButton
        self.numberofPages = 0
        self.primaryButton = nil
        self.modalView = AndesModalContainer.provideView(for: options, with: actions)
        super.init(nibName: nil, bundle: nil)
        self.setup(for: options.type, with: modalView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPrimaryButton(_ isCarousel: Bool) {
        guard isCarousel, let button = primaryButton else { return }
        button.hierarchy = .quiet

        let size = AndesButtonSizeFactory.provideStyle(key: button.size, icon: button.icon)
        button.clipsToBounds = true
        button.layer.cornerRadius = size.borderRadius
    }

    private func setup(for type: AndesModalType, with modalView: AndesModalView) {
        modalPresentationStyle = .overCurrentContext
        view.backgroundColor = .clear
        view.addSubview(modalView)
        setNeedsStatusBarAppearanceUpdate()

        modalView.delegate = self
        modalView.pinToSuperview()

        if type == .card && allowsCloseButton {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(close))
            tapGesture.delegate = self
            modalView.isUserInteractionEnabled = true
            modalView.addGestureRecognizer(tapGesture)
        }
    }

    private static func provideView(
        for options: AndesModalOptions,
        with actions: AndesModalActions = AndesModalActions()
    ) -> AndesModalView {
        let config = AndesModalViewConfig(options: options, with: actions)
        switch options.type {
        case .fullscreen:
            if options.isCarousel {
                return AndesModalFullCarouselView(with: config)
            }
            return AndesModalFullView(with: config)

        case .card:
            if options.isCarousel {
                return AndesModalCardCarouselView(with: config)
            }
            return AndesModalCardView(with: config)
        }
    }

    private static func provideView(
        for options: AndeModalCustomViewOptions,
        with actions: AndesModalActions = AndesModalActions()
    ) -> AndesModalView {
        guard let customView = options.customView else {
            preconditionFailure("custom view can't be nil")
        }
        let internalOptions = AndesModalOptions()
        internalOptions.contentSize = options.contentSize
        internalOptions.title = options.title
        internalOptions.type = options.type
        internalOptions.allowsCloseButton = options.allowsCloseButton
        internalOptions.ignoreHorizontalMargins = options.ignoreHorizontalMargins

        let config = AndesModalViewConfig(options: internalOptions, with: actions)
        switch options.type {
        case.fullscreen:
            return AndesModalFullCustomView(for: customView, with: config)

        case .card:
            return AndesModalCardCustomView(for: customView, with: config)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if animateAppear {
            modalView.alpha = 0
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        if animateAppear {
            modalView.animateAppear()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return modalView.preferredStatusBarStyle
    }

    /// In the initial screens, the main action button will have the `.quiet` hierarchy.
    /// on the last page this changes to `.loud`
    /// - Parameter page: current page to determine button hierarchy
    private func updatePrimaryButtonHierarchy(_ page: Int) {
        let hierarchy: AndesButtonHierarchy = page == self.numberofPages - 1 ? .loud : .quiet
        guard
            let button = primaryButton,
            let buttonView = button.view as? AndesButtonAbstractView,
            button.hierarchy != hierarchy else {
            return
        }

        let style = AndesButtonHierarchyFactory.provideStyle(key: hierarchy)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1, delay: 0) {
            buttonView.backgroundLayer.backgroundColor = style.idleColor.cgColor
            buttonView.label.textColor = style.fontColor
        } completion: { _ in
            button.hierarchy = hierarchy
        }
    }

    @objc
    public func show(in parentVC: UIViewController) {
        parentVC.present(self, animated: false)
    }

    @objc
    public func close() {
        modalView.animateDisappear()
    }
}

extension AndesModalContainer: AndesModalViewDelegate {
    func andesModalView(_ view: AndesModalView, didTouchLink index: Int, at label: AndesLabelType, of page: Int) {
        delegate?.andesModal?(self, didTouchLink: index, at: label, of: currentPage)
    }

    func andesModalViewDidDissmis(_ view: AndesModalView) {
        primaryButton?.hierarchy = .loud
        dismiss(animated: false)
        delegate?.andesModalDidClose(self)
    }

    func andesModalView(_ view: AndesModalView, didPageChangeTo page: Int) {
        updatePrimaryButtonHierarchy(page)
        currentPage = page
        delegate?.andesModal?(self, didPageChangeTo: page)
    }
}

extension AndesModalContainer: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view === modalView
    }
}
