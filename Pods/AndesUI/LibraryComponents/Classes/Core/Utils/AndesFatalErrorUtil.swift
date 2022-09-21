//
//  AndesFatalErrorUtil.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 21/02/22.
//

import Foundation

/// Utility functions that can replace and restore the `fatalError` global function.

@objc
public class FatalErrorUtil: NSObject {
    /// Called by the custom implementation of `fatalError`.
    static var fatalErrorClosure: (String, StaticString, UInt) -> Never = defaultFatalErrorClosure

    /// backup of the original Swift `fatalError`
    private static let defaultFatalErrorClosure = {
        Swift.fatalError($0, file: $1, line: $2)
    }

    /// Replace the `fatalError` global function with something else.
    public static func replaceFatalError(closure: @escaping (String, StaticString, UInt) -> Never) {
        fatalErrorClosure = closure
    }

    /// Restore the `fatalError` global function back to the original Swift implementation
    public static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}
