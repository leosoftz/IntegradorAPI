//
//  AndesBaseTooltipView+Methods.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 18-02-21.
//

import Foundation

extension AndesBaseTooltipView {
    func show(target targetView: UIView, position: AndesTooltipPosition, sizeStyle: AndesTooltipWidthSize = .dynamic) {
        if let firstWindow = UIApplication.shared.windows.first {
            self.bubblePosition = adjustTooltipPosition(with: position, sizeStyle: sizeStyle)
            presentingView = targetView
            arrange(withinSuperview: firstWindow, sizeStyle: sizeStyle)
            firstWindow.addSubview(self)
            self.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)

            transform = CGAffineTransform(translationX: 0, y: animationTransform)
            alpha = 0

            UIView.animate(withDuration: self.animationDuration, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
                self?.alpha = 1
                self?.transform = .identity
            })
        }
    }

    @available(*, deprecated, renamed: "show(target:position:sizeStyle:)", message: "Please use new func show")
    func show(target targetView: UIView, withinSuperview superview: UIView, position: AndesTooltipPosition, sizeStyle: AndesTooltipWidthSize = .dynamic) {
        self.bubblePosition = adjustTooltipPosition(with: position, sizeStyle: sizeStyle)
        presentingView = targetView
        arrange(withinSuperview: superview, sizeStyle: sizeStyle)
        superview.addSubview(self)
        self.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)

        transform = CGAffineTransform(translationX: 0, y: animationTransform)
        alpha = 0

        UIView.animate(withDuration: self.animationDuration, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
            self?.alpha = 1
            self?.transform = .identity
        })
    }

    func dismiss() {
        UIView.animate(withDuration: self.animationDuration, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
            self?.frame.origin.y += self?.animationTransform ?? 0
            self?.alpha = 0
        }) { [weak self] _ in
            self?.delegate?.onDismissed()
            self?.removeFromSuperview()
        }
    }

    private func adjustTooltipPosition(with position: AndesTooltipPosition, sizeStyle: AndesTooltipWidthSize) -> AndesTooltipPosition {
        if sizeStyle == .fullSize && (position == .left || position == .right) {
            return .top
        }
        return position
    }
}
