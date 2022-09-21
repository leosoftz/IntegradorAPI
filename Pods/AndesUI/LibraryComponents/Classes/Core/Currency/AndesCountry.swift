//
//  AndesCountry.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 27/09/21.
//

import Foundation

@objc public enum AndesCountry: Int, AndesEnumStringConvertible {
    case DEFAULT
    case MNI
    case MLC
    case MLV
    case MHN
    case MPY
    case MBO
    case MLU
    case MCR
    case MLM
    case MSV
    case MGT
    case MPA
    case MRD
    case MLA
    case MCO
    case MPE
    case MPR
    case MCU
    case MLB
    case MEC

    public static func keyFor(_ value: AndesCountry) -> String {
        switch value {
        case MNI:
            return "MNI"
        case MLC:
            return "MLC"
        case MLV:
            return "MLV"
        case MHN:
            return "MHN"
        case MPY:
            return "MPY"
        case MBO:
            return "MBO"
        case MLU:
            return "MLU"
        case MCR:
            return "MCR"
        case MLM:
            return "MLM"
        case MSV:
            return "MSV"
        case MGT:
            return "MGT"
        case MPA:
            return "MPA"
        case MRD:
            return "MRD"
        case MLA:
            return "MLA"
        case MCO:
            return "MCO"
        case MPE:
            return "MPE"
        case MPR:
            return "MPR"
        case MCU:
            return "MCU"
        case MLB:
            return "MLB"
        case MEC:
            return "MEC"
        case .DEFAULT:
            return "DEFAULT"
        }
    }
}
