//
//  AndesThumbnailSize72.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 25/06/2020.
//

internal struct AndesThumbnailSize72: AndesThumbnailSizeProtocol {
	var size: CGFloat
	var cornerRadius: CGFloat
	var borderWidth: CGFloat = 1.0
	var iconSize: CGFloat
	var outlineWidth: CGFloat = 3.0

	init(type: AndesThumbnailTypeProtocol) {
		size = 72
		cornerRadius = type.circular ? size / 2 : 5.0
		iconSize = 32
	}
}
