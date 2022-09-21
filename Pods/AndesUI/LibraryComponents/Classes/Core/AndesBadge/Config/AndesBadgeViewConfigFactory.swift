//
//  AndesBadgeViewConfigFactory.swift
//  AndesUI
//
//  Created by Ignacio Guri on 20/03/2020.
//

import Foundation

internal class AndesBadgeViewConfigFactory {
    static func provideInternalConfig(fromPill pill: AndesBadgePill) -> AndesBadgeViewConfig {
        let typeIns = AndesBadgeTypeFactory.provide(pill.type)
        let hierarchyIns = AndesBadgeHierarchyFactory.provide(pill.hierarchy, forType: typeIns)
        let pillText = pill.text
        let sizeStyle = AndesBadgeSizeFactory.provide(pill.size)
        let roundedCorners = AndesBadgeBorderFactory.provide(pill.border).corners

        let config = AndesBadgeViewConfig(backgroundColor: hierarchyIns.backgroundColor, text: pillText, sizeStyle: sizeStyle, textColor: hierarchyIns.textColor, roundedCorners: roundedCorners)

        return config
    }

    static func provideInternalConfig(fromDot dot: AndesBadgeDot) -> AndesBadgeViewConfig {
        let backgroundColor = AndesBadgeTypeFactory.provide(dot.type).primaryColor
        let dotText = ""
        let sizeStyle = AndesBadgeSizeDot()
        let textColor = UIColor.clear

        let config = AndesBadgeViewConfig(backgroundColor: backgroundColor, text: dotText, sizeStyle: sizeStyle, textColor: textColor)

        return config
    }

    static func provideInternalConfig(fromIcon icon: AndesBadgeIcon) -> AndesBadgeViewConfig {
        let sizeStyle = AndesBadgeSizeFactory.provide(icon.size)

        let type = AndesBadgeTypeFactory.provide(icon.iconType.andesBadgeType())
        let backgroundColor = AndesBadgeIconHierarchyFactory.provide(icon.hierarchy, forType: type).backgroundColor

        let icon = AndesBadgeTypeFactory.provide(icon.iconType.andesBadgeType()).getIcon?(size: icon.size) ?? ""

        let config = AndesBadgeViewConfig(icon: icon, backgroundColor: backgroundColor, sizeStyle: sizeStyle)

        return config
    }
}
