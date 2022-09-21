//
//  ResultWrapper.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//

import UIKit

struct ResultWrapper {
    let id, title: String
    let type: ProductTypeEnum
    let soldQuantity: Int
    let price: Double
    let condition: String
    let picturesURL: [String?]
    let thumbnail: String?
    let freeShipping: Bool?
    
    init(_ item: ItemDetail) {
        self.id = item.id
        self.title = item.title
        self.price = item.price!
        self.type = .item
        self.soldQuantity = item.soldQuantity
        self.condition = item.condition ?? ""
        var pictures = [String]()
        item.pictures?.forEach({
            pictures.append($0.secureURL!)
        })
        self.picturesURL = pictures
        self.thumbnail = item.secureThumbnail
        self.freeShipping = item.shipping?.freeShippings
    }
    
    init(_ result: ProductDetail) {
        self.id = result.id
        self.title = result.name
        self.price = result.buyBoxWinner?.price! ?? 0.0
        self.type = .product
        self.soldQuantity = result.soldQuantity
        self.condition = result.buyBoxWinner?.condition ?? ""
        var pictures = [String]()
        result.pictures?.forEach({
            pictures.append($0.url)
        })
        self.picturesURL = pictures
        self.thumbnail = (result.pickers?.first?.products?.first?.thumbnail!) ?? nil
        self.freeShipping = result.buyBoxWinner?.shipping?.freeShipping
    }
}

