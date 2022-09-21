//
//  DefaultsLinearProgress.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 8/09/21.
//

import Foundation

@objc(DefaultsLinearProgress) public class DefaultsLinearProgress: NSObject {
    @objc public static let trackTint: UIColor = UIColor.Andes.gray100
    @objc public static let indicatorTint: UIColor = UIColor.Andes.blueML500
    @objc public static let size: AndesLinearProgressIndicatorSize = .small
    @objc public static let splitSize: Int = 0
    @objc public static let cornerRadius: Int = 0
    @objc public static let allRoundedCorner: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    @objc public static let topBottomRightRoundedCorner: CACornerMask = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    @objc public static let topBottomLeftRoundedCorner: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    @objc public static let isSplit: Bool = false
    @objc public static let numberOfSteps: Int = 10
    @objc public static let minNumberOfSteps = 1
    @objc public static let maxNumberOfSteps = 20
    @objc public static let stepInitial: Int = 0
    @objc public static let stepOne: Int = 1
    @objc public static let stepTwo: Int = 2
}
