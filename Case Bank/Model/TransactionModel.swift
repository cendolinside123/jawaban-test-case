//
//  TransactionModel.swift
//  Case Bank
//
//  Created by Jan Sebastian on 16/01/24.
//

import Foundation


struct TransactionInfoModel {
    let bank: String
    let transactionID: String
    let merchanName: String
    let price: Int
}

struct TransactionLogModel {
    let id: String
    let bank: String
    let transactionID: String
    let merchanName: String
    let price: Int
    let tanggal: Date
    let status: TransactionState
}
