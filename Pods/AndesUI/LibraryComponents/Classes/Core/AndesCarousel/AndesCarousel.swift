//
//  AndesCarousel.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 04/02/2021.
//

import UIKit

@objc public class AndesCarousel: UIView {
    private var contentView: AndesCarouselView!

    @objc public weak var delegate: AndesCarouselDelegate?
    /// Set the dataSource to use own methods
    @objc public weak var dataSource: AndesCarouselDataSource? {
        didSet {
            self.updateContentView()
        }
    }
    @objc public var margin: AndesCarouselMargin = .defaultMargin {
        didSet {
            self.reDrawContentViewIfNeededThenUpdate()
        }
    }
    @objc public var mode: AndesCarouselMode = .free {
        didSet {
            self.updateContentView()
        }
    }

    @IBInspectable public var title: String? {
        didSet {
            self.updateContentView()
        }
    }

    @IBInspectable public var usePaginator: Bool = false {
        didSet {
            self.updateContentView()
        }
    }

    @IBInspectable public var isInfinityScroll: Bool = false {
        didSet {
            self.updateContentView()
        }
    }

    @IBInspectable public var isAutoScroll: Bool = false {
        didSet {
            self.updateContentView()
        }
    }

    @IBInspectable public var autoScrollSpeed: TimeInterval = 3.0 {
        didSet {
            self.updateContentView()
        }
    }

    @objc public init(title: String = String(),
                      margin: AndesCarouselMargin = .defaultMargin,
                      mode: AndesCarouselMode = .free,
                      usePaginator: Bool = false,
                      delegate: AndesCarouselDelegate? = nil,
                      isInfinityScroll: Bool = false) {
        self.title = title
        self.margin = margin
        self.mode = mode
        self.usePaginator = usePaginator
        self.delegate = delegate
        self.isInfinityScroll = isInfinityScroll
        super.init(frame: .zero)
        setup()
    }

    @objc public init(title: String = String(),
                      margin: AndesCarouselMargin = .defaultMargin,
                      mode: AndesCarouselMode = .free,
                      usePaginator: Bool = false,
                      delegate: AndesCarouselDelegate? = nil) {
        self.title = title
        self.margin = margin
        self.mode = mode
        self.usePaginator = usePaginator
        self.delegate = delegate
        super.init(frame: .zero)
        setup()
    }
    /**
     Constructor for the Carousel when it is used by interface builder
     By defect, it will be .icon and .default
     */
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        let contentView = provideContentView()
        drawContentView(with: contentView)
    }

    private func drawContentView(with contentView: AndesCarouselView) {
        self.contentView = contentView
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.pinToSuperview()
    }

    private func provideContentView() -> AndesCarouselView {
        let config = AndesCarouselViewConfigFactory.provide(for: self)
        return AndesCarouselTypeCardViewFactory.provide(for: config, view: self)
    }

    private func updateContentView() {
        let config = AndesCarouselViewConfigFactory.provide(for: self)
        contentView.update(withConfig: config)
    }

    /// Check if view needs to be redrawn, and then update it. This method should be called on all modifiers that may need to change which internal view should be rendered
    private func reDrawContentViewIfNeededThenUpdate() {
        let newView = provideContentView()
        if Swift.type(of: newView) !== Swift.type(of: contentView) {
            contentView.removeFromSuperview()
            drawContentView(with: newView)
        } else {
            updateContentView()
        }
    }
}

// MARK: - IB interface
public extension AndesCarousel {
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'margin' instead.")
    @IBInspectable var ibMargin: String {
        set(val) {
            self.margin = AndesCarouselMargin.checkValidEnum(property: "IB margin", key: val)
        }
        get {
            return self.margin.toString()
        }
    }

    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'mode' instead.")
    @IBInspectable var ibMode: String {
        set(val) {
            self.mode = AndesCarouselMode.checkValidEnum(property: "IB mode", key: val)
        }
        get {
            return self.mode.toString()
        }
    }
}

extension AndesCarousel: AndesCarouselViewProtocol {
    func indexNumberChanged(indexPath: IndexPath) {
        delegate?.andesCarousel?(self, currentIndexChanged: indexPath)
    }

    func cellForRowAt(indexPath: IndexPath) -> UIView {
        return (dataSource?.andesCarousel(self, cellForRowAt: indexPath)) ?? UIView()
    }

    func numberOfRow() -> Int {
        return dataSource?.getDataSetSize(self) ?? 0
    }

    func didSelectItemAt(indexPath: IndexPath) {
        delegate?.andesCarousel(self, didSelectItemAt: indexPath)
    }

    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        delegate?.andesCarousel?(self, sizeForItemAt: indexPath) ?? CGSize.zero
    }
}
