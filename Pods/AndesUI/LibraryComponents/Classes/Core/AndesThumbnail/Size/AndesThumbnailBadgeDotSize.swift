//
//  AndesThumbnailBadgeDotSize.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 24/08/21.
//

import Foundation

@objc public enum AndesThumbnailBadgeDotSize: Int, AndesEnumStringConvertible {
	var thumbnailSizeValue: AndesThumbnailSize {
		switch self {
		case .size24: return .size24
		case .size32: return .size32
		}
	}

	case size24
	case size32

	public static func keyFor(_ value: AndesThumbnailBadgeDotSize) -> String {
		switch value {
		case .size24: return "size_24"
		case .size32: return "size_32"
		}
	}
}
