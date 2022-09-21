//
//  AndesThumbnailBadgePillSize.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 24/08/21.
//

import Foundation

@objc public enum AndesThumbnailBadgePillSize: Int, AndesEnumStringConvertible {
	var thumbnailSizeValue: AndesThumbnailSize {
		switch self {
		case .size40: return .size40
		case .size48: return .size48
		case .size56: return .size56
		case .size64: return .size64
		case .size72: return .size72
		case .size80: return .size80
		}
	}

	case size40
	case size48
	case size56
	case size64
	case size72
	case size80

	public static func keyFor(_ value: AndesThumbnailBadgePillSize) -> String {
		switch value {
		case .size40: return "size_40"
		case .size48: return "size_48"
		case .size56: return "size_56"
		case .size64: return "size_64"
		case .size72: return "size_72"
		case .size80: return "size_80"
		}
	}
}
