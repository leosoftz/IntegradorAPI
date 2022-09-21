//
//  ProductDetail.swift
//  IntegradorAPI
//
//  Created by Leonardo Agustin Zabala on 19/09/2022.
//



import Foundation

// MARK: - ProductDetail
struct ProductDetail: Codable {
    let id, status: String
    let soldQuantity: Int
    let domainID: String?
    let permalink: String?
    let name: String
    let familyName: String?
    let buyBoxWinner: BuyBoxWinner?
    let buyBoxWinnerPriceRange: BuyBoxWinnerPriceRange?
    let pickers: [Picker]?
    let pictures: [Picture]?
    let mainFeatures: [MainFeature]?
    let attributes: [ProductDetailAttribute]?
    let shortDescription: ShortDescription?
    let parentID: String?
    let childrenIDS: [JSONAny]?
    let settings: Settings?

    enum CodingKeys: String, CodingKey {
        case id, status
        case soldQuantity = "sold_quantity"
        case domainID = "domain_id"
        case permalink, name
        case familyName = "family_name"
        case buyBoxWinner = "buy_box_winner"
        case buyBoxWinnerPriceRange = "buy_box_winner_price_range"
        case pickers, pictures
        case mainFeatures = "main_features"
        case attributes
        case shortDescription = "short_description"
        case parentID = "parent_id"
        case childrenIDS = "children_ids"
        case settings
    }
}

// MARK: - ProductDetailAttribute
struct ProductDetailAttribute: Codable {
    let id, name: String?
    let valueID: String?
    let valueName: String?
    let values: [Value]?
    let meta: Meta?

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueID = "value_id"
        case valueName = "value_name"
        case values, meta
    }
}

// MARK: - Meta
struct Meta: Codable {
    let value: Bool?
    let rgb: String?
}

// MARK: - Value
struct Value: Codable {
    let id, name: String?
    let meta: Meta?
}

// MARK: - BuyBoxWinner
struct BuyBoxWinner: Codable {
    let itemID, categoryID: String?
    let sellerID: Int?
    let price: Double?
    let currencyID: String?
    let soldQuantity, availableQuantity: Int?
    let installments: Installments?
    let shipping: Shipping?
    let warranty, condition: String?
    let saleTerms: [SaleTerm]?
    let officialStoreID: Int?
    let originalPrice: Double?
    let listingTypeID: String?
    let acceptsMercadopago: Bool?
    let sellerAddress: SellerAddress?
    let internationalDeliveryMode: String?
    let tags: [String?]?
    let itemOverrideAttributes: [JSONAny]?
    let dealIDS: [String?]?
    let tier, productID: String?
    let experiments: JSONNull?

    enum CodingKeys: String, CodingKey {
        case itemID = "item_id"
        case categoryID = "category_id"
        case sellerID = "seller_id"
        case price
        case currencyID = "currency_id"
        case soldQuantity = "sold_quantity"
        case availableQuantity = "available_quantity"
        case installments, shipping, warranty, condition
        case saleTerms = "sale_terms"
        case officialStoreID = "official_store_id"
        case originalPrice = "original_price"
        case listingTypeID = "listing_type_id"
        case acceptsMercadopago = "accepts_mercadopago"
        case sellerAddress = "seller_address"
        case internationalDeliveryMode = "Int?ernational_delivery_mode"
        case tags
        case itemOverrideAttributes = "item_override_attributes"
        case dealIDS = "deal_ids"
        case tier
        case productID = "product_id"
        case experiments
    }
}

// MARK: - Installments
struct Installments: Codable {
    let quantity, amount, rate: Int?
    let currencyID: String?

    enum CodingKeys: String, CodingKey {
        case quantity, amount, rate
        case currencyID = "currency_id"
    }
}

// MARK: - SaleTerm
struct SaleTerm: Codable {
    let id, name: String?
    let valueID: String?
    let valueName: String?
    let valueStruct: ValueStruct?

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueID = "value_id"
        case valueName = "value_name"
        case valueStruct = "value_struct"
    }
}

// MARK: - ValueStruct
struct ValueStruct: Codable {
    let number: Int?
    let unit: String?
}

// MARK: - SellerAddress
struct SellerAddress: Codable {
    let city, state: City?
}

// MARK: - City
struct City: Codable {
    let name: String?
}

// MARK: - Shipping
struct Shipping: Codable {
    let mode: String?
    let tags: [String?]?
    let freeShipping: Bool?
    let logisticType: String?
    let storePickUp: Bool?

    enum CodingKeys: String, CodingKey {
        case mode, tags
        case freeShipping = "free_shipping"
        case logisticType = "logistic_type"
        case storePickUp = "store_pick_up"
    }
}

// MARK: - BuyBoxWinnerPriceRange
struct BuyBoxWinnerPriceRange: Codable {
    let min, max: Max?
}

// MARK: - Max
struct Max: Codable {
    let price: Double?
    let currencyID: String?

    enum CodingKeys: String, CodingKey {
        case price
        case currencyID = "currency_id"
    }
}

// MARK: - MainFeature
struct MainFeature: Codable {
    let text, type: String?
    let metadata: Metadata?
}

// MARK: - Metadata
struct Metadata: Codable {
    let key, value: String?
}

// MARK: - Picker
struct Picker: Codable {
    let pickerID, pickerName: String?
    let products: [Product]?
    let tags: JSONNull?
    let attributes: [PickerAttribute]?

    enum CodingKeys: String, CodingKey {
        case pickerID = "picker_id"
        case pickerName = "picker_name"
        case products, tags, attributes
    }
}

// MARK: - PickerAttribute
struct PickerAttribute: Codable {
    let attributeID, template: String?

    enum CodingKeys: String, CodingKey {
        case attributeID = "attribute_id"
        case template
    }
}

// MARK: - Product
struct Product: Codable {
    let productID, pickerLabel, pictureID: String?
    let thumbnail: String?
    let tags: [String?]?
    let permalink: String?

    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
        case pickerLabel = "picker_label"
        case pictureID = "picture_id"
        case thumbnail, tags, permalink
    }
}

// MARK: - Picture
struct Picture: Codable {
    let id: String?
    let url: String
    let suggestedForPicker: [String?]?
    let maxWidth, maxHeight: Int?

    enum CodingKeys: String, CodingKey {
        case id, url
        case suggestedForPicker = "suggested_for_picker"
        case maxWidth = "max_width"
        case maxHeight = "max_height"
    }
}

// MARK: - Settings
struct Settings: Codable {
    let listingStrategy: String?
    let hasRichDescription: Bool?

    enum CodingKeys: String, CodingKey {
        case listingStrategy = "listing_strategy"
        case hasRichDescription = "has_rich_description"
    }
}

// MARK: - ShortDescription
struct ShortDescription: Codable {
    let type, content: String?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
