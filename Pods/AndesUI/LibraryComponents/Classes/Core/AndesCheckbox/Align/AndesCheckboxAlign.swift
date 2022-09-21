//
//  AndesCheckboxAlign.swift
//  AndesUI
//
//  Created by Rodrigo Pintos Costa on 6/16/20.
//

import Foundation
/// Used to set the checkbox align
@objc public enum AndesCheckboxAlign: Int, AndesEnumStringConvertible {
    case left
    case right

    public static func keyFor(_ value: AndesCheckboxAlign) -> String {
        switch value {
        case .left: return "LEFT"
        case .right: return "RIGHT"
        }
    }
}

@objc
public enum AndesCheckboxContext: Int, AndesEnumStringConvertible {
    case component, textField

    public static func keyFor(_ value: AndesCheckboxContext) -> String {
        switch value {
        case .component: return "COMPONENT"
        case .textField: return "TEXTFIELD"
        }
    }
}

internal struct AndesCheckboxConstraint {
    let labelToLeadingConstraint: CGFloat
    let labelToTrailingConstraint: CGFloat
}

internal enum AndesCheckboxConstraintFactory {
    static func retrieveConstraints(align: AndesCheckboxAlign, context: AndesCheckboxContext) -> AndesCheckboxConstraint {
        switch context {
        case .component:
            return retrieveComponentConstraints(align: align)
        case .textField:
            return retrieveTextFieldConstraints(align: align)
        }
    }

    private static func retrieveTextFieldConstraints(align: AndesCheckboxAlign) -> AndesCheckboxConstraint {
        switch align {
        case .left:
            return AndesCheckboxConstraintFactory.andesTextFieldComponentCheckboxLeft
        case .right:
            return AndesCheckboxConstraintFactory.andesTextFieldComponentCheckboxRight
        }
    }

    private static func retrieveComponentConstraints(align: AndesCheckboxAlign) -> AndesCheckboxConstraint {
        switch align {
        case .left:
            return AndesCheckboxConstraintFactory.defaultPaddingLeft
        case .right:
            return AndesCheckboxConstraintFactory.defaultPaddingRight
        }
    }

    private static var defaultPaddingLeft: AndesCheckboxConstraint {
        AndesCheckboxConstraint(labelToLeadingConstraint: 28.0, labelToTrailingConstraint: 12.0)
    }

    private static var defaultPaddingRight: AndesCheckboxConstraint {
        AndesCheckboxConstraint(labelToLeadingConstraint: 12.0, labelToTrailingConstraint: 28.0)
    }

    private static var andesTextFieldComponentCheckboxLeft: AndesCheckboxConstraint {
        AndesCheckboxConstraint(labelToLeadingConstraint: 24.0, labelToTrailingConstraint: 12.0)
    }

    private static var andesTextFieldComponentCheckboxRight: AndesCheckboxConstraint {
        AndesCheckboxConstraint(labelToLeadingConstraint: 12.0, labelToTrailingConstraint: 24.0)
    }
}
