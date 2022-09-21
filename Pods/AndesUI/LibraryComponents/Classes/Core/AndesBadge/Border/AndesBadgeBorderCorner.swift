//
//  AndesBadgeBorderCorner.swift
//  AndesUI
//

internal struct AndesBadgeBorderCorner: AndesBadgeBorderProtocol {
    public var corners: CACornerMask = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
}

internal struct AndesBadgeBorderCornerLeft: AndesBadgeBorderProtocol {
    public var corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
}
