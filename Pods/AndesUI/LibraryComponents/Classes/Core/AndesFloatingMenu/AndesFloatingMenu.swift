//  AndesFloatingMenuSimpleView.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 26/05/2021.
//

import Foundation
import UIKit

@objc open class AndesFloatingMenu: UIView, AndesAccessibleView {
    private let parentView: UIView
    private var searchbox: AndesSearchbox?
    let andesList: AndesList
    private let animationDuration = 0.150
    private let fromFrame: CGRect
    private let numberOfRows: Int
    private let heigthNavBar: CGFloat
    private let rowsDisplayed: AndesFloatingMenuNumberRow
    private var tableHeight: CGFloat = 0
    private var openPosition: OpenPosition = (typeVertical:.down, typeHorizontal: .left)
    internal var isShowed: AndesFloatingMenuStatus
    internal let transparentView = UIView()
    private var widthType: AndesFloatingMenuWidthType
    private var showFrom: AndesFloatingOpenTypeHorizontal
    private let margin = CGFloat(16)
    private var rowHeight = CGFloat(0)
    private var fixedWidth: CGFloat
    private let offset = CGFloat(12)
    private let overflow = CGFloat(0.5)

    @objc public weak var delegate: AndesFloatingMenuShowProtocol?

    var accessibilityManager: AndesAccessibilityManager?

    @objc public init(config: AndesFloatingMenuConfig) {
        self.showFrom = config.showFrom
        self.searchbox = config.searchbox
        self.andesList = config.andesList
        self.parentView = config.parentView
        self.widthType = config.widthType
        self.fromFrame = config.fromFrame
        self.rowsDisplayed = config.rowsDisplayed
        self.heigthNavBar = config.heigthNavBar
        self.fixedWidth = config.fixedWidth
        self.numberOfRows = self.andesList.numberOfRows()
        self.isShowed = .closed
        super.init(frame: CGRect.zero)
        self.setupViews()
        self.retrieveRowHeight()
        self.backgroundColor = UIColor.clear
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.parentView.addSubview(self.transparentView)
        self.parentView.addSubview(self.andesList)
        self.andesList.translatesAutoresizingMaskIntoConstraints = true
        self.andesList.layer.zPosition = 1
        self.andesList.layer.shadowColor = UIColor.black.cgColor
        self.andesList.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        self.andesList.layer.shadowOpacity = 0.1
        self.andesList.layer.shadowRadius = 16
        self.andesList.layer.cornerRadius = 6
        self.andesList.layer.shouldRasterize = true
        self.andesList.layer.rasterizationScale = UIScreen.main.scale

        self.accessibilityManager = AndesFloatingMenuAccessibilityManager(view: self)

        self.andesList.closureAccessibilityPerformEscape = { [weak self] in
            self?.close()
            (self?.accessibilityManager as? AndesFloatingMenuAccessibilityManager)?.onAccessibilityPerformEscapeActivated()
        }
    }

    private func retrieveRowHeight() {
        let cell = self.andesList.cellForRowAt(indexPath: IndexPath(item: 0, section: 0))
        self.rowHeight = AndesListCellFactory.provide(withSize: self.andesList.size,
                                                      subTitleIsEmpty: cell.subtitle.isEmpty,
                                                      thumbnail: cell.thumbnail).height
    }

    @objc public func close() {
        if self.isShowed != .closed {
            UIView.animate(withDuration: self.animationDuration, delay: 0, options: .curveEaseIn, animations: {
                self.transparentView.alpha = 0
                self.andesList.frame = self.frameClosed
                self.removeSearchBox()
                self.andesList.layoutIfNeeded()
            }, completion: { _ in
                self.transparentView.removeFromSuperview()
                self.andesList.removeFromSuperview()
                self.isShowed = .closed
                self.delegate?.onHide()
            })
        }
    }

    @objc public func open() {
        if self.isShowed == .closed {
            addTransparentView()
            addSearchbox()
            self.changeOrientationIfOverflowVertical()
            self.changeOrientationIfOverflowHorizontal()
            let frameOpen = self.frameOpen
            self.andesList.frame = self.frameClosed
            self.andesList.setNeedsLayout()
            self.andesList.layoutIfNeeded()

            UIView.animate(withDuration: self.animationDuration, delay: 0, options: .curveEaseOut, animations: {
                self.andesList.frame = frameOpen
                self.andesList.layoutIfNeeded()
            }, completion: {_ in
                self.isShowed = .open(openPosition: self.openPosition)
                (self.accessibilityManager as? AndesFloatingMenuAccessibilityManager)?  .onFloatingMenuOpenAccessibilityActivated()
                self.delegate?.onShow()
            })
        }
    }

    private func addTransparentView() {
        self.transparentView.frame = self.parentView.frame
        self.transparentView.backgroundColor = UIColor.clear
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(close))
        transparentView.addGestureRecognizer(tapgesture)
    }

    private func changeOrientationIfOverflowHorizontal() {
        let width = self.widthWithMargin
        let available = self.availableHorizontalSpace
        switch self.widthType {
        case .custom:
            switch self.showFrom {
            case .left:
                if width <= available.0 {
                    self.openPosition.typeHorizontal = .left
                } else if width <= available.1 {
                    self.openPosition.typeHorizontal = .right
                } else {
                    self.openPosition.typeHorizontal = self.fitWith
                    self.widthType = .custom
                    self.fixedWidth = self.openPosition.typeHorizontal == .left ? available.0 : available.1
                    self.fixedWidth = self.fixedWidth - self.margin
                }
            case .right:
                if width <= available.1 {
                    self.openPosition.typeHorizontal = .right
                } else if width <= available.0 {
                    self.openPosition.typeHorizontal = .left
                } else {
                    self.openPosition.typeHorizontal = self.fitWith
                    self.widthType = .custom
                    self.fixedWidth = self.openPosition.typeHorizontal == .left ? available.0 : available.1
                    self.fixedWidth = self.fixedWidth - self.margin
                }
            }
        case .fixed:
            self.openPosition.typeHorizontal = self.showFrom
        }
    }

    private var fitWith: AndesFloatingOpenTypeHorizontal {
        let available = self.availableHorizontalSpace
        if available.0 > available.1 {
            return .left
        } else {
            return .right
        }
    }

    private var widthWithMargin: CGFloat {
        var width = CGFloat(0)
        switch self.widthType {
        case .custom:
            width = CGFloat(self.fixedWidth + margin)
        default:
            width = self.fromFrame.width + CGFloat(margin)
        }
        return width
    }

    private var fitMaxSize: CGFloat {
        let available = self.availableVerticalSpace
        let maxAvailable = max(available.0, available.1)
        self.openPosition.typeVertical = available.0 > available.1 ? .up : .down
        let maxRowsWithOutRounded = (maxAvailable / self.rowHeight)
        let maxRowsRounded = maxRowsWithOutRounded.rounded(.down)
        let overflowRowSpaceFix = (maxRowsWithOutRounded - maxRowsRounded) >= 0.5 ? 0 : 1
        let rowsToShow = (maxRowsRounded - CGFloat(overflowRowSpaceFix) + 0.5)
        return rowsToShow * self.rowHeight
    }

    private func changeOrientationIfOverflowVertical() {
        self.tableHeight = self.heightOfList
        let available = self.availableVerticalSpace
        switch self.openPosition.typeVertical {
        case .down:
            if self.tableHeight <= available.1 {
            } else if self.tableHeight <= available.0 {
                self.openPosition.typeVertical = .up
            } else {
                self.tableHeight = self.fitMaxSize
            }
        case .up:
            if self.tableHeight <= available.0 {
            } else if self.tableHeight <= available.1 {
                self.openPosition.typeVertical = .down
            } else {
                self.tableHeight = self.fitMaxSize
            }
        }
    }

    private var floatingWidth: CGFloat {
        var width = CGFloat(0)
        switch self.widthType {
        case .fixed:
            width = self.fromFrame.width
        case .custom:
            width = self.fixedWidth
        }
        return width
    }

    private var frameOpen: CGRect {
        var frameOpen: CGRect
        switch (self.openPosition.typeVertical, self.openPosition.typeHorizontal) {
        case (.down, .right):
            frameOpen = CGRect(x: self.fromFrame.minX, y: self.fromFrame.maxY, width: self.floatingWidth, height: self.tableHeight)
        case (.down, .left):
            let xOrigin = self.fromFrame.minX - (self.floatingWidth - fromFrame.width)
            frameOpen = CGRect(x: xOrigin, y: self.fromFrame.maxY, width: self.floatingWidth, height: self.tableHeight)
        case (.up, .right):
            frameOpen = CGRect(x: self.fromFrame.minX, y: self.fromFrame.minY, width: self.floatingWidth, height: -self.tableHeight)
        case (.up, .left):
            let xOrigin = self.fromFrame.minX - (self.floatingWidth - self.fromFrame.width)
            frameOpen = CGRect(x: xOrigin, y: self.fromFrame.minY, width: self.floatingWidth, height: -self.tableHeight)
        }
        frameOpen = frameOpen.offsetBy(dx: 0, dy: self.openPosition.typeVertical == .down ? self.offset : -self.offset )
        return frameOpen
    }

    private var frameClosed: CGRect {
        var frameClosed: CGRect
        if self.openPosition.typeVertical == .down {
            let offset = self.offset
            frameClosed = self.frameOpen
            frameClosed  = CGRect(origin: frameClosed.origin, size: CGSize(width: frameClosed.width, height: 0))
            frameClosed  = frameClosed.offsetBy(dx: 0, dy: -1.5 * offset)
        } else {
            let offset = -self.offset
            frameClosed = self.frameOpen
            frameClosed  = CGRect(x: frameClosed.minX, y: frameClosed.maxY, width: frameClosed.width, height: 0)
            frameClosed  = frameClosed.offsetBy(dx: 0, dy: -1.5 * offset)
        }
        return frameClosed
    }

    private var heightOfList: CGFloat {
        let quantityWithOverFlow = CGFloat(self.rowsDisplayed.rawValue) + self.overflow
        let minQuantity = CGFloat(self.numberOfRows)
        let quantity = min(quantityWithOverFlow, minQuantity)
        return self.rowHeight * (quantity)
    }

    private var availableVerticalSpace: (CGFloat, CGFloat) {
        let lowerSpace = self.parentView.bounds.height - self.fromFrame.maxY - self.margin
        let upperSpace = self.fromFrame.minY - self.heigthNavBar - self.margin
        return (upperSpace, lowerSpace)
    }

    private var availableHorizontalSpace: (CGFloat, CGFloat) {
        let leftSpace = self.fromFrame.maxX
        let rightSpace = self.parentView.bounds.width - self.fromFrame.maxX
        return (leftSpace, rightSpace)
    }
}

extension AndesFloatingMenu {
    private func addSearchbox() {
        guard let searchbox = self.searchbox else { return }
        andesList.tableView.tableHeaderView = searchbox
        searchbox.widthAnchor.constraint(equalTo: andesList.widthAnchor).isActive = true
    }

    private func removeSearchBox() {
        andesList.tableView.tableHeaderView = nil
    }
}
