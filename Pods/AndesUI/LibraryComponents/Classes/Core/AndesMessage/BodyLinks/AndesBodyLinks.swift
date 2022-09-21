//
//  AndesBodyLinks.swift
//  AndesUI
//
//  Created by Marcelo Agustin Gil on 27/07/2020.
//
@objc
public class AndesBodyLinks: NSObject {
    var links: [AndesBodyLink]
    var listener: ((_ index: Int) -> Void)

    public init(links: [AndesBodyLink], listener: @escaping ((_ index: Int) -> Void)) {
        self.links = links
        self.listener = listener
    }

    @objc public init(links: NSArray, listener: @escaping ((_ index: Int) -> Void)) {
        self.links = links as? [AndesBodyLink] ?? []
        self.listener = listener
    }
}
