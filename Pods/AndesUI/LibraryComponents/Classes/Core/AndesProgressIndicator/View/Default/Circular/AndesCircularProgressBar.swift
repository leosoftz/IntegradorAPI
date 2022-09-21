//
//  AndesCircularProgressBar.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 01-12-20.
//

import UIKit

@IBDesignable
internal class AndesCircularProgressBar: UIView {
    enum AnimationType {
        case infinity
        case madeProgress(progress: CGFloat)
    }

    @IBInspectable var color: UIColor? {
        didSet {
            self.updateLayers()
            setNeedsDisplay()
        }
    }

    @IBInspectable var ringWidth: CGFloat = 10 {
        didSet {
            self.updateLayers()
            setNeedsDisplay()
        }
    }

    var progress: CGFloat = 0 {
        didSet {
            self.updateLayers()
            setNeedsDisplay()
        }
    }

    private var progressLayer = CAShapeLayer()
    private let rotationAnimationDuration: Double = 2
    private let strokeAnimationDuration: Double = 1.5

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }

     private func updateLayers() {
        let size = self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        self.progressLayer.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.progressLayer.position = CGPoint(x: size.width / 2, y: size.height / 2)

        let circle = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        self.progressLayer.path = circle.cgPath
        self.progressLayer.fillColor = UIColor.clear.cgColor
        self.progressLayer.lineWidth = ringWidth
        self.progressLayer.strokeStart = 0
        self.progressLayer.strokeEnd = progress
        self.progressLayer.lineCap = .round
        self.progressLayer.strokeColor = color?.cgColor
    }

    private func setupView() {
        self.backgroundColor = .clear
        layer.addSublayer(progressLayer)
    }

    func startAnimation(_ type: AnimationType) {
        switch type {
        case .infinity:
            self.startInfiniteAnimation()
        case .madeProgress:
            break
        }
    }

    private func startInfiniteAnimation() {
        self.animateRotation()
        self.animateStroke()
    }

    func stopAnimation() {
        self.layer.removeAllAnimations()
        self.progressLayer.removeAllAnimations()
    }

    private func animateStroke() {
        let strokeAnimationMidDuration = strokeAnimationDuration / 2

        let beginAnimation = AndesStrokeAnimation(
            type: .end,
            fromValue: 0.0,
            toValue: 0.75,
            duration: strokeAnimationMidDuration
        )

        let midAnimation = AndesStrokeAnimation(
            type: .start,
            beginTime: 0.75,
            fromValue: 0.0,
            toValue: 0.97,
            duration: strokeAnimationMidDuration
        )

        let endAnimation = AndesStrokeAnimation(
            type: .end,
            beginTime: 0.75,
            fromValue: 0.75,
            toValue: 1,
            duration: strokeAnimationMidDuration
        )

        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = strokeAnimationDuration
        strokeAnimationGroup.repeatDuration = .infinity
        strokeAnimationGroup.isRemovedOnCompletion = false
        strokeAnimationGroup.animations = [
            beginAnimation,
            midAnimation,
            endAnimation
        ]

        progressLayer.add(strokeAnimationGroup, forKey: "startAnimation")
    }

    private func animateRotation() {
        let rotationAnimation = AndesRotationAnimation(
            direction: .axisZ,
            fromValue: 0,
            toValue: CGFloat.pi * 2,
            duration: rotationAnimationDuration,
            repeatCount: .infinity
        )

        self.layer.add(rotationAnimation, forKey: "rotateAnimation")
    }
}
