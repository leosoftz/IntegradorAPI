//
//  AndesDatePickerStartOfTheWeek.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 5/05/22.
//

import Foundation

/**
 Represents the start of week day in the Datepicker, the start of week can be at the monday or sunday
 */
@objc
public enum AndesDatePickerStartOfWeek: Int, AndesEnumStringConvertible {
    case monday
    case sunday

    public static func keyFor(_ value: AndesDatePickerStartOfWeek) -> String {
        switch value {
        case .monday: return "MONDAY"
        case .sunday: return "SUNDAY"
        }
    }
}
