//
//  ItemDetail.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//

import Foundation

// MARK: - ProductDetail
struct ItemDetail: Codable {
    let id, siteID, title: String
    let subtitle: String?
    let sellerID: Int?
    let categoryID: String?
    let officialStoreID: Int?
    let price, basePrice, originalPrice: Double?
    let currencyID: String?
    let initialQuantity, availableQuantity: Int?
    let soldQuantity: Int
    let saleTerms: [SaleTerms]?
    let buyingMode, listingTypeID, startTime, stopTime: String?
    let condition: String?
    let permalink: String?
    let thumbnailID: String?
    let thumbnail: String?
    let secureThumbnail: String?
    let pictures: [Pictures]?
    let videoID: String?
    let descriptions: [JSONAny]?
    let acceptsMercadopago: Bool?
    let nonMercadoPagoPaymentMethods: [JSONAny]?
    let shipping: Shippings?
    let internationalDeliveryMode: String?
    let sellerAddress: SellerAddresss?
    let sellerContact: JSONNull?
    let location: Location?
    let coverageAreas: [JSONAny]?
    let attributes: [Attributes]?
    let warnings: [JSONAny]?
    let listingSource: String?
    let variations: [Variation]?
    let status: String?
    let subStatus: [JSONAny]?
    let tags: [String]?
    let warranty: String?
    let catalogProductID: String?
    let domainID: String?
    let parentItemID, differentialPricing: JSONNull?
    let dealIDS: [String]?
    let automaticRelist: Bool?
    let dateCreated, lastUpdated: String?
    let health: Double?
    let catalogListing: Bool?
    let channels: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case siteID = "site_id"
        case title, subtitle
        case sellerID = "seller_id"
        case categoryID = "category_id"
        case officialStoreID = "official_store_id"
        case price
        case basePrice = "base_price"
        case originalPrice = "original_price"
        case currencyID = "currency_id"
        case initialQuantity = "initial_quantity"
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case saleTerms = "sale_terms"
        case buyingMode = "buying_mode"
        case listingTypeID = "listing_type_id"
        case startTime = "start_time"
        case stopTime = "stop_time"
        case condition, permalink
        case thumbnailID = "thumbnail_id"
        case thumbnail
        case secureThumbnail = "secure_thumbnail"
        case pictures
        case videoID = "video_id"
        case descriptions
        case acceptsMercadopago = "accepts_mercadopago"
        case nonMercadoPagoPaymentMethods = "non_mercado_pago_payment_methods"
        case shipping
        case internationalDeliveryMode = "Int?ernational_delivery_mode"
        case sellerAddress = "seller_address"
        case sellerContact = "seller_contact"
        case location
        case coverageAreas = "coverage_areas"
        case attributes, warnings
        case listingSource = "listing_source"
        case variations, status
        case subStatus = "sub_status"
        case tags, warranty
        case catalogProductID = "catalog_product_id"
        case domainID = "domain_id"
        case parentItemID = "parent_item_id"
        case differentialPricing = "differential_pricing"
        case dealIDS = "deal_ids"
        case automaticRelist = "automatic_relist"
        case dateCreated = "date_created"
        case lastUpdated = "last_updated"
        case health
        case catalogListing = "catalog_listing"
        case channels
    }
}

// MARK: - Attribute
struct Attributes: Codable {
    let id, name: String?
    let valueID, valueName: String?
    let valueStruct: Struct?
    let values: [Values]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueID = "value_id"
        case valueName = "value_name"
        case valueStruct = "value_struct"
        case values
    }
}

enum AttributeGroupID: String, Codable {
    case others = "OTHERS"
}

enum AttributeGroupName: String, Codable {
    case otros = "Otros"
}

// MARK: - Struct
struct Struct: Codable {
    let number: Double?
    let unit: String?
}

// MARK: - Values
struct Values: Codable {
    let id, name: String?
    let valueStruct: Struct?

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueStruct = "struct"
    }
}

// MARK: - Location
struct Location: Codable {
}

// MARK: - Pictures
struct Pictures: Codable {
    let id: String?
    let url: String?
    let secureURL: String?
    let size, maxSize, quality: String?

    enum CodingKeys: String, CodingKey {
        case id, url
        case secureURL = "secure_url"
        case size
        case maxSize = "max_size"
        case quality
    }
}

// MARK: - SaleTerms
struct SaleTerms: Codable {
    let id, name: String?
    let valueID: String?
    let valueName: String?
    let valueStruct: Struct?
    let values: [Values]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueID = "value_id"
        case valueName = "value_name"
        case valueStruct = "value_struct"
        case values
    }
}

// MARK: - SellerAddresss
struct SellerAddresss: Codable {
    let city: City?
    let state, country: Country?
    let searchLocation: SearchLocation?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case city, state, country
        case searchLocation = "search_location"
        case id
    }
}

// MARK: - Country
struct Country: Codable {
    let id, name: String?
}

// MARK: - SearchLocation
struct SearchLocation: Codable {
    let neighborhood, city, state: Country?
}

// MARK: - Shippings
struct Shippings: Codable {
    let mode: String?
    let freeMethods: [FreeMethod]?
    let tags: [String?]?
    let dimensions: String?
    let localPickUp, freeShippings: Bool?
    let logisticType: String?
    let storePickUp: Bool?

    enum CodingKeys: String, CodingKey {
        case mode
        case freeMethods = "free_methods"
        case tags, dimensions
        case localPickUp = "local_pick_up"
        case freeShippings = "free_shipping"
        case logisticType = "logistic_type"
        case storePickUp = "store_pick_up"
    }
}

// MARK: - FreeMethod
struct FreeMethod: Codable {
    let id: Int?
    let rule: Rule?
}

// MARK: - Rule
struct Rule: Codable {
    let ruleDefault: Bool?
    let freeMode: String?
    let freeShippingsFlag: Bool?
    let value: JSONNull?

    enum CodingKeys: String, CodingKey {
        case ruleDefault = "default"
        case freeMode = "free_mode"
        case freeShippingsFlag = "free_shipping_flag"
        case value
    }
}

// MARK: - Variation
struct Variation: Codable {
    let id: Int?
    let price: Double?
    let attributeCombinations: [SaleTerms]?
    let availableQuantity, soldQuantity: Int?
    let saleTerms: [JSONAny]?
    let pictureIDS: [String?]
    let catalogProductID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case price
        case attributeCombinations = "attribute_combinations"
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case saleTerms = "sale_terms"
        case pictureIDS = "picture_ids"
        case catalogProductID = "catalog_product_id"
    }
}

