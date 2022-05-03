//
//  WomenOfMarvelModel.swift
//  WomenOfMarvel
//
//  Created by fmustafa on 5/2/22.
//

import Foundation

// MARK: - WomenOfMarvel
struct WomenOfMarvel: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.dataClassTask(with: url) { dataClass, response, error in
//     if let dataClass = dataClass {
//       ...
//     }
//   }
//   task.resume()

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Result]
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.resultTask(with: url) { result, response, error in
//     if let result = result {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Result
struct Result: Codable {
    let id, digitalID: Int
    let title: String
    let issueNumber: Int
    let variantDescription, resultDescription, modified, isbn: String
    let upc, diamondCode, ean, issn: String
    let format: String
    let pageCount: Int
    let textObjects: [TextObject]
    let resourceURI: String
    let urls: [URLElement]
    let series: Series
    let variants, collections, collectedIssues: [JSONAny]
    let dates: [DateElement]
    let prices: [Price]
    let thumbnail: Thumbnail
    let images: [Thumbnail]
    let creators: Creators
    let characters: Characters
    let stories: Stories
    let events: Characters

    enum CodingKeys: String, CodingKey {
        case id
        case digitalID = "digitalId"
        case title, issueNumber, variantDescription
        case resultDescription = "description"
        case modified, isbn, upc, diamondCode, ean, issn, format, pageCount, textObjects, resourceURI, urls, series, variants, collections, collectedIssues, dates, prices, thumbnail, images, creators, characters, stories, events
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.charactersTask(with: url) { characters, response, error in
//     if let characters = characters {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Characters
struct Characters: Codable {
    let available: Int
    let collectionURI: String
    let items: [Series]
    let returned: Int
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.seriesTask(with: url) { series, response, error in
//     if let series = series {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Series
struct Series: Codable {
    let resourceURI: String
    let name: String
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.creatorsTask(with: url) { creators, response, error in
//     if let creators = creators {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Creators
struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.creatorsItemTask(with: url) { creatorsItem, response, error in
//     if let creatorsItem = creatorsItem {
//       ...
//     }
//   }
//   task.resume()

// MARK: - CreatorsItem
struct CreatorsItem: Codable {
    let resourceURI: String
    let name: String
    let role: Role
}

enum Role: String, Codable {
    case colorist = "colorist"
    case pencillerCover = "penciller (cover)"
    case writer = "writer"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.dateElementTask(with: url) { dateElement, response, error in
//     if let dateElement = dateElement {
//       ...
//     }
//   }
//   task.resume()

// MARK: - DateElement
struct DateElement: Codable {
    let type, date: String
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.thumbnailTask(with: url) { thumbnail, response, error in
//     if let thumbnail = thumbnail {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.priceTask(with: url) { price, response, error in
//     if let price = price {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Price
struct Price: Codable {
    let type: String
    let price: Double
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.storiesTask(with: url) { stories, response, error in
//     if let stories = stories {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Stories
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.storiesItemTask(with: url) { storiesItem, response, error in
//     if let storiesItem = storiesItem {
//       ...
//     }
//   }
//   task.resume()

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String
    let name, type: String
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.textObjectTask(with: url) { textObject, response, error in
//     if let textObject = textObject {
//       ...
//     }
//   }
//   task.resume()

// MARK: - TextObject
struct TextObject: Codable {
    let type, language, text: String
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.uRLElementTask(with: url) { uRLElement, response, error in
//     if let uRLElement = uRLElement {
//       ...
//     }
//   }
//   task.resume()

// MARK: - URLElement
struct URLElement: Codable {
    let type: String
    let url: String
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func womenOfMarvelTask(with url: URL, completionHandler: @escaping (WomenOfMarvel?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
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
