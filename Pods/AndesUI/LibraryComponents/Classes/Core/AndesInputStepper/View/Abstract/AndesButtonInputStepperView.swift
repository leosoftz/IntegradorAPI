//
//  AndesButtonInputStepperView.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 19/01/22.
//

import UIKit

internal class AndesButtonInputStepperView: UIControl {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTargets()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTargets()
    }

    internal func setupContentView (config: AndesInputStepperViewConfig) {
        setRectangleShape(cornerRadius: config.size.cornerRadius, roundedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner])
    }

    private func setupTargets() {
        self.addTarget(self, action: #selector(touchDown), for: .touchDragInside)
        self.addTarget(self, action: #selector(touchDown), for: .touchDown)

        self.addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchUp), for: .touchDragOutside)
    }

    @objc func touchUp() {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.layer.backgroundColor = DefaultsInputStepper.idleColor.cgColor
            },
            completion: nil
        )
    }

    @objc func touchDown() {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                self.layer.backgroundColor = DefaultsInputStepper.pressedColor.cgColor
            },
            completion: nil
        )
    }
}

// MARK: drawings
extension AndesButtonInputStepperView {
    internal func drawAdd(config: AndesInputStepperViewConfig, color: UIColor?, lineWidth: CGFloat = 1.2) {
        self.layer.sublayers?.removeAll()
        let width = config.size.buttonWidth
        let height = config.size.buttonHeight
        let top = config.size.iconTopConstraint
        let lateral = config.size.iconLateralConstraint

        let points = [
            CGPoint(x: lateral, y: height / 2),
            CGPoint(x: width - lateral, y: height / 2),
            CGPoint(x: width / 2, y: height - top),
            CGPoint(x: width / 2, y: top)
        ]

        let path = UIBezierPath()
        path.move(to: points[0])
        path.addLine(to: points[1])
        path.move(to: points[2])
        path.addLine(to: points[3])

        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = color?.cgColor
        layer.lineWidth = lineWidth
        self.layer.addSublayer(layer)
    }

    internal func drawMinus(config: AndesInputStepperViewConfig, color: UIColor?, lineWidth: CGFloat = 1.2) {
        self.layer.sublayers?.removeAll()
        let width = config.size.buttonWidth
        let height = config.size.buttonHeight
        let lateral = config.size.iconLateralConstraint
        let points: [CGPoint] = [
            CGPoint(x: lateral, y: height / 2),
            CGPoint(x: width - lateral, y: height / 2)
        ]

        let path = UIBezierPath()
        path.move(to: points[0])
        path.addLine(to: points[1])

        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = color?.cgColor
        layer.lineWidth = lineWidth
        self.layer.addSublayer(layer)
    }
}
