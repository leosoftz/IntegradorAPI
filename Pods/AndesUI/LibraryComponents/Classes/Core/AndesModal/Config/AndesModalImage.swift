//
//  AndesModalImage.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 2/06/22.
//

import UIKit

/// Provides an image to a modal
///
/// Create image from local resource
///
///     let image = UIImage(named: "test")
///     AndesModalImage(image)
///
/// Create image from remore location
///
///     AndesModalImage { completion in
///         MLODRemoteResources.sharedInstance()
///             .getImageWithName("test", placeItIn: nil, success: completion)
///     }
///
///     AndesModalImage { completion in
///         publisher
///             .replaceError(with: errorImage)
///             .sink(receiveValue: completion)
///     }
@objc
public class AndesModalImage: NSObject {
    public typealias ImageProvider = (@escaping(UIImage?) -> Void) -> Void
    private var image: UIImage?
    private let provider: ImageProvider?
    private let placeholder: UIImage?

    /// Provide  an static image
    /// - Parameters:
    ///   - image: Image to display.
    ///   - label: The localized label that represents the element for accesibility.
    @objc
    public init(_ image: UIImage, label: String? = nil) {
        self.image = image
        self.provider = nil
        self.placeholder = nil
        super.init()
        self.accessibilityLabel = label
    }

    /// Provide  asynchronous image loading
    /// - Parameters:
    ///   - label: The localized label that represents the element for accesibility, `nil` by default.
    ///   - placeholder: Placeholder to be displayed when the image is loading. `nil` by default.
    ///   - provider: The block to execute when image is needed, Always execute this block at some point during your implementation of this method.
    @objc
    public init(label: String? = nil, placeholder: UIImage? = nil, provider: @escaping ImageProvider) {
        self.image = nil
        self.provider = provider
        self.placeholder = placeholder
        super.init()
        self.accessibilityLabel = label
    }
}

internal extension AndesModalImage {
    func setImage(in imageView: UIImageView) {
        if let image = image {
            imageView.image = image
            return
        }
        guard let provider = provider else {
            preconditionFailure("modal needs an image or resource")
        }
        imageView.image = placeholder
        provider { [weak self, weak imageView] image in
            self?.image = image
            DispatchQueue.main.async {
                imageView?.image = image
            }
        }
    }
}
