//
//  AndesThumbnailSize32.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 25/06/2020.
//

import Foundation

internal struct AndesThumbnailSize32: AndesThumbnailSizeProtocol {
	var size: CGFloat
	var cornerRadius: CGFloat
	var borderWidth: CGFloat = 1.0
	var iconSize: CGFloat
	var outlineWidth: CGFloat = 2.0

	init(type: AndesThumbnailTypeProtocol) {
		size = 32
		cornerRadius = type.circular ? size / 2 : 3.0
		iconSize = 20
	}
}
