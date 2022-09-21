//
//  AndesBadgeIconHierarchyFactory.swift
//  AndesUI
//
//  Created by Eden Torres on 01/11/2021.
//

internal class AndesBadgeIconHierarchyFactory {
    static func provide(_ hierarchy: AndesBadgeIconHierarchy, forType type: AndesBadgeTypeProtocol) -> AndesBadgeHierarchyProtocol {
        switch hierarchy {
        case .loud:
            return AndesBadgeHierarchyLoud(type: type)
        case .secondary:
            return AndesBadgeHierarchySecondary(type: type)
        }
    }
}
