//
//  TransactionDataSource.swift
//  Case Bank
//
//  Created by Jan Sebastian on 16/01/24.
//

import Foundation
import RxSwift

protocol TransactionDataSource {
    func inputTransaction(id: String, bank: String, transactionID: String, merchanName: String, price: Int, tanggal: Date, status: TransactionState) -> Completable
    func loadListTransaction() -> Single<[TransactionLogModel]>
}


