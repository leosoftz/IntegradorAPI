//
//  AndesModalCardAnimator.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 1/06/22.
//

import UIKit

class AndesModalCardAnimator {
    let contentDuration: TimeInterval = 0.200
    let closeButtonDuration: TimeInterval = 0.100
    let transform: CGAffineTransform = .init(translationX: 0, y: 40)

    func animateAppear(view: UIView, containerView: UIView, dismissButton: UIButton) {
        view.alpha = 0
        containerView.transform = transform
        UIView.animate(withDuration: contentDuration, delay: 0, options: .curveEaseOut) {
            view.alpha = 1
            containerView.transform = .identity
        }
        dismissButton.alpha = 0
        UIView.animate(withDuration: closeButtonDuration, delay: 0, options: .curveEaseOut) {
            dismissButton.alpha = 1
        }
    }

    func animateDisappear(view: UIView, containerView: UIView, dismissButton: UIButton, completion:  @escaping () -> Void) {
        UIView.animate(withDuration: contentDuration, delay: 0, options: .curveEaseIn) {
            containerView.transform = self.transform
            view.alpha = 0
        } completion: { _ in
            completion()
        }

        UIView.animate(withDuration: closeButtonDuration, delay: closeButtonDuration, options: .curveEaseOut) {
            dismissButton.alpha = 0
        }
    }
}
