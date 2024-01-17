//
//  PromoModel.swift
//  Case Bank
//
//  Created by Jan Sebastian on 17/01/24.
//

import Foundation

enum UnknowData: Codable {
    case StringValue(String)
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .StringValue(x)
            return
        }
        throw DecodingError.typeMismatch(UnknowData.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UnknowData"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .StringValue(let x):
            try container.encode(x)
        }
    }
}

struct PromoModel: Codable {
    
}


// MARK: - ErrorAPI
struct ErrorAPI: Codable {
//    let data: Any?
    let error: ErrorInfo
}

// MARK: - ErrorInfo
struct ErrorInfo: Codable {
    let status: Int
    let name, message: String
    let details: Details
}

// MARK: - Details
struct Details: Codable {
}
