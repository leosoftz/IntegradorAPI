//
//  ArrayBuilder.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 13/06/22.
//

import Foundation

/// A function builder for generating arrays of any element without requiring full array literal syntax.
///
/// Use the  this function builder to simplify the implementation of array
///
///      struct ContentModel {
///         var views: [Item] {
///             [
///                 Item(),
///                 Item()
///             ]
///         }
///     }
///
/// With the builder, you can omit the array literal syntax:
///
///     struct ContentModel {
///         @ArrayBuilder<Item>
///         var views: [Item] {
///             Item()
///             Item()
///         }
///     }
///
@resultBuilder
public enum ArrayBuilder<Element> {
    public static func buildBlock() -> [Element] {
        []
    }

    public static func buildBlock(_ components: Element?...) -> [Element] {
        return components.compactMap { $0 }
    }

    public static func buildBlock(_ elements: [Element]?...) -> [Element] {
        return elements.compactMap { $0 }.flatMap { $0 }
    }

    public static func buildExpression(_ expression: Element?) -> [Element] {
        [expression].compactMap { $0 }
    }

    public static func buildEither(first component: [Element]) -> [Element] {
        return component
    }

    public static func buildEither(second component: [Element]) -> [Element] {
        return component
    }

    public static func buildArray(_ components: [[Element]]) -> [Element] {
        return components.flatMap { $0 }
    }

    static func buildOptional(_ component: [Element]?) -> [Element] {
        return component ?? []
    }
}
