//
//  AndesPageControlView.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 13/04/2021.
//

import UIKit
public protocol AndesPageControlViewDelegate: AnyObject {
    /// Tells the delegate that the visible page was changed
    /// - Parameters:
    ///   - control: current page control
    ///   - page: new index of visible page
    func andesPageControl(_ control: AndesPageControlView, didPageChangeTo page: Int)
}

open class AndesPageControlView: UIView, AndesAccessibleView {
    private var lastSize = CGSize.zero
    private let limitDots = 2
    private let slideDuration: TimeInterval = 0.2
    private var spacing: CGFloat = 4.0
    private(set) var dotSize: CGFloat = 6.0
    private var maxDots: Int = 5
    private(set) var selectedPage: Int = 0 {
        didSet {
            updatePositions(isAnimated: true)
            updateColors()
        }
    }

    open var pages: Int = 0 {
        didSet {
            guard pages != oldValue else { return }
            pages = max(0, pages)
            createLayers()
        }
    }

    private var dotLayers: [CALayer] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperlayer() }
            dotLayers.forEach(layer.addSublayer)
            updateColors()
            updatePositions()
        }
    }

    open var dotColor = UIColor.Andes.graySolid250 {
        didSet {
            updateColors()
        }
    }

    open var selectedColor = AndesStyleSheetManager.styleSheet.accentColor {
        didSet {
            updateColors()
        }
    }

    internal var accessibilityManager: AndesAccessibilityManager?
    public weak var delegate: AndesPageControlViewDelegate?

    // MARK: Init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureDots()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
        self.configureDots()
    }

    func configureDots(dotSize: CGFloat = 6.0, spacing: CGFloat = 4.0) {
        self.spacing = spacing
        self.dotSize = dotSize
        self.dotLayers.forEach {
            $0.frame = CGRect(origin: .zero, size: CGSize(width: dotSize, height: dotSize))
        }
        layer.masksToBounds = true
        updatePositions()
        updateColors(isAnimated: false)
        accessibilityManager = AndesPageControlViewAccesibilityManager(view: self)
    }

    private func createLayers() {
        configureDots()
        dotLayers = (0..<pages).map { _ in
            AndesPageDotLayer(size: dotSize)
        }
    }

    /// Not call delegate metods 
    func currentPage(_ page: Int) {
        guard selectedPage != page else { return }
        selectedPage = max(0, min(page, pages - 1))
        accessibilityManager?.viewUpdated()
    }

    // MARK: updates methods

    private func updateColors(isAnimated: Bool = true) {
        dotLayers.enumerated().forEach { page, dot in
            dot.backgroundColor = page == selectedPage ? selectedColor.cgColor : dotColor.cgColor
        }
    }

    private func getPosition(page: Int, dot: CALayer, dotFullSize: CGFloat, dotBoxMinX: CGFloat) -> CGFloat {
            let offset: Int
            if selectedPage < limitDots || self.pages <= maxDots {
                offset = page
            } else if selectedPage >= (self.pages - 1) - limitDots {
                offset = page - (self.pages - (limitDots * 2)) + 1
            } else {
                offset = page - selectedPage + limitDots
            }
            return dotBoxMinX + bounds.minX + dotSize / 2 + dotFullSize * CGFloat(offset)
    }

    private func getScale(page: Int, dot: CALayer) -> CGFloat {
            var scale: CGFloat = .nan
            let distance: CGFloat = CGFloat(abs(page - selectedPage))
            if page == selectedPage {
                scale = 1.0
            } else if (selectedPage <= limitDots && page >= maxDots) ||
                        (selectedPage >= ((self.pages - 1) - limitDots) && page < (self.pages - maxDots)) {
                scale = 0.0
            } else if selectedPage > limitDots, selectedPage < (self.pages - 1) - limitDots, distance > CGFloat(limitDots) {
                scale = 0.0
            } else {
                let maxDots = CGFloat(self.maxDots)
                scale = max(0.0, (maxDots - (distance - 1))) / maxDots
            }
            return scale
    }

    private func updatePositions(isAnimated: Bool = false) {
        let dotFullSize = dotSize + spacing
        let pages = min(self.pages, maxDots)
        let dotBoxMinX = bounds.midX - ((dotSize * CGFloat(pages)) + (spacing * (CGFloat(pages) - 1))) / 2.0
        dotLayers.enumerated().forEach { (page: Int, dot: CALayer) in
            let position = getPosition(page: page, dot: dot, dotFullSize: dotFullSize, dotBoxMinX: dotBoxMinX)
            let scale = getScale(page: page, dot: dot)

            if isAnimated {
                let positionAnimation = CABasicAnimation(keyPath: "position.x")
                positionAnimation.fromValue = dot.value(forKey: "position.x")
                positionAnimation.toValue = position
                positionAnimation.duration = slideDuration

                let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
                scaleAnimation.fromValue = dot.value(forKey: "transform.scale")
                scaleAnimation.toValue = (floor(scale * dotSize) == 0.0) ? 0.0 : scale

                let animtaionGroup = CAAnimationGroup()
                animtaionGroup.animations = [positionAnimation, scaleAnimation]
                animtaionGroup.duration = slideDuration
                animtaionGroup.timingFunction = CAMediaTimingFunction(name: .easeOut)
                animtaionGroup.fillMode = .forwards
                animtaionGroup.isRemovedOnCompletion = false

                dot.add(animtaionGroup, forKey: nil)
            } else {
                dot.position = CGPoint(x: position, y: dotSize / 2.0)
                dot.transform = CATransform3DScale(CATransform3DIdentity, scale, scale, scale)
            }
        }
    }

    // MARK: override methods
    override open func layoutSubviews() {
        super.layoutSubviews()
        guard bounds.size != lastSize else { return }
        lastSize = bounds.size
        updatePositions()
    }

    override open var intrinsicContentSize: CGSize {
        let maxDistance = 4
        var numberOfDots = self.pages

        if self.pages > limitDots {
            numberOfDots = limitDots + maxDistance
        }
        let width = CGFloat(numberOfDots) * dotSize + CGFloat(numberOfDots - 1) * spacing
        let height = dotSize

        return CGSize(width: width, height: height)
    }

    override open func accessibilityIncrement() {
        (accessibilityManager as? AndesPageControlViewAccesibilityManager)?.accessibilityIncrement()
    }

    override open func accessibilityDecrement() {
        (accessibilityManager as? AndesPageControlViewAccesibilityManager)?.accessibilityDecrement()
    }
}
