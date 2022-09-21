//
//  AndesMoneyAmountSize.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 24/08/21.
//

import Foundation

/// Used to define the size of an AndesMoneyAmount
@objc public enum AndesMoneyAmountSize: Int, AndesEnumStringConvertible {
    case size12
    case size14
    case size16
    case size18
    case size20
    case size24
    case size28
    case size32
    case size36
    case size40
    case size44
    case size48
    case size52
    case size56
    case size60

    public static func keyFor(_ value: AndesMoneyAmountSize) -> String {
        switch value {
        case size12:
            return "12"
        case size14:
            return "14"
        case size16:
            return "16"
        case size18:
            return "18"
        case size20:
            return "20"
        case size24:
            return "24"
        case size28:
            return "28"
        case size32:
            return "32"
        case size36:
            return "36"
        case size40:
            return "40"
        case size44:
            return "44"
        case size48:
            return "48"
        case size52:
            return "52"
        case size56:
            return "56"
        case size60:
            return "60"
        }
    }

    public static func superScriptSizeFor(_ value: AndesMoneyAmountSize) -> CGFloat {
        switch value {
        case size12:
            FatalErrorUtil.fatalErrorClosure("This size  is not valid for superscript select a higher value", #file, #line)

        case size14, size16, size18, size20:
            return 10
        case size24:
            return 12
        case size28:
            return 14
        case size32:
            return 16
        case size36:
            return 18
        case size40:
            return 20
        case size44:
            return 22
        case size48:
            return 24
        case size52:
            return 26
        case size56:
            return 28
        case size60:
            return 30
        }
    }

    public static func iconSizeFor(_ value: AndesMoneyAmountSize) -> CGFloat {
        switch value {
        case size12, size14, size16:
            return 16
        case size18, size20:
            return 20
        case size24:
            return 24
        case size28:
            return 28
        case size32:
            return 32
        case size36, size40, size44, size48, size52, size56, size60:
            return 0
        }
    }

    public static func currencyIconSizeFor(_ value: AndesMoneyAmountSize) -> CGFloat {
        switch value {
        case size12:
            return 9
        case size14:
            return 11
        case size16:
            return 13
        case size18:
            return 15
        case size20:
            return 17
        case size24:
            return 20
        case size28:
            return 22
        case size32:
            return 24
        case size36:
            return 27
        case size40:
            return 28
        case size44:
            return 32
        case size48:
            return 34
        case size52:
            return 38
        case size56:
            return 41
        case size60:
            return 43
        }
    }

    public static func currencyIconPaddingFor(_ value: AndesMoneyAmountSize) -> CGFloat {
        switch value {
        case size12, size14, size16:
            return 3
        case size18, size20:
            return 4
        case size24, size28, size32:
            return 5
        case size36:
            return 6
        case size40:
            return 7
        case size44, size48:
            return 8
        case size52, size56, size60:
            return 10
        }
    }

    public static func suffixSizeFor(_ value: AndesMoneyAmountSize) -> CGFloat {
        switch value {
        case size12:
            return 0
        case size14:
            return 9
        case size16:
            return 10
        case size18:
            return 12
        case size20:
            return 13
        case size24:
            return 16
        case size28:
            return 18
        case size32:
            return 21
        case size36:
            return 24
        case size40:
            return 26
        case size44:
            return 28
        case size48:
            return 32
        case size52:
            return 34
        case size56:
            return 36
        case size60:
            return 38
        }
    }

    public static func suffixPaddingFor(_ value: AndesMoneyAmountSize) -> CGFloat {
        switch value {
        case size12:
            return 0
        case size14:
            return 2
        case size16, size18:
            return 3
        case size20:
            return 4
        case size24:
            return 6
        case size28, size32:
            return 7
        case size36:
            return 8
        case size40:
            return 10
        case size44:
            return 11
        case size48:
            return 12
        case size52:
            return 13
        case size56:
            return 14
        case size60:
            return 15
        }
    }
}
