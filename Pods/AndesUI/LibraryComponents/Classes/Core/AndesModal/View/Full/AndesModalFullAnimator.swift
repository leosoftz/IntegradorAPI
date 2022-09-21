//
//  AndesModalFullAnimator.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 1/06/22.
//

import UIKit

class AndesModalFullAnimator {
    let contentDuration: TimeInterval = 0.350
    let closeButtonDuration: TimeInterval = 0.100

    func animateAppear(view: UIView, dismissButton: UIButton? = nil) {
        view.alpha = 1
        let content = view.superview ?? view
        content.transform = .init(translationX: 0, y: UIScreen.main.bounds.maxY)
        UIView.animate(withDuration: contentDuration, delay: 0, options: .curveEaseOut) {
            content.transform = .identity
        }

        guard let dismissButton = dismissButton else {
            return
        }
        dismissButton.alpha = 0
        UIView.animate(withDuration: closeButtonDuration, delay: 0, options: .curveEaseOut) {
            dismissButton.alpha = 1
        }
    }

    func animateDisappear(view: UIView, dismissButton: UIButton? = nil, completion:  @escaping () -> Void) {
        guard let content = view.superview else { return }
        UIView.animate(withDuration: contentDuration, delay: 0, options: .curveEaseIn) {
            content.layer.frame.origin.y = UIScreen.main.bounds.maxY
        } completion: { _ in
            completion()
        }

        guard let dismissButton = dismissButton else {
            return
        }
        dismissButton.alpha = 1
        UIView.animate(withDuration: closeButtonDuration, delay: 0.25, options: .curveEaseIn) {
            dismissButton.alpha = 0
        }
    }
}
