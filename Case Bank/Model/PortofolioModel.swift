//
//  PortofolioModel.swift
//  Case Bank
//
//  Created by Jan Sebastian on 17/01/24.
//

import Foundation

// MARK: - PortifilioModelElement
struct PortofolioModel: Codable {
    let type: String
    let data: DataUnion
}

enum DataUnion: Codable {
    case dataLine(DataLineModel)
    case dataDataDonut([DataDonutModel])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([DataDonutModel].self) {
            self = .dataDataDonut(x)
            return
        }
        if let x = try? container.decode(DataLineModel.self) {
            self = .dataLine(x)
            return
        }
        throw DecodingError.typeMismatch(DataUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DataUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dataLine(let x):
            try container.encode(x)
        case .dataDataDonut(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DataDonutModel
struct DataDonutModel: Codable {
    let label, percentage: String
    let data: [DetailPortoModel]
}

// MARK: - DetailPortoModel
struct DetailPortoModel: Codable {
    let trxDate: String
    let nominal: Int

    enum CodingKeys: String, CodingKey {
        case trxDate = "trx_date"
        case nominal
    }
}

// MARK: - DataLineModel
struct DataLineModel: Codable {
    let month: [Int]
}

typealias PortofolioList = [PortofolioModel]
