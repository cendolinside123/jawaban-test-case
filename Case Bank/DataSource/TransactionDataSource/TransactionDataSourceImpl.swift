//
//  TransactionDataSourceImpl.swift
//  Case Bank
//
//  Created by Jan Sebastian on 16/01/24.
//

import Foundation
import RxSwift


struct TransactionDataSourceImpl {
    
}

extension TransactionDataSourceImpl: TransactionDataSource {
    func inputTransaction(id: String, bank: String, transactionID: String, merchanName: String, price: Int, tanggal: Date, status: TransactionState) -> RxSwift.Completable {
        return Completable.create(subscribe: { emmiter in
            
            let inputData = TransactionLogModel(id: id, bank: bank, transactionID: transactionID, merchanName: merchanName, price: price, tanggal: tanggal, status: status)
            DummyStorage.listTransaksi.append(inputData)
            emmiter(.completed)
            return Disposables.create()
        })
    }
    
    func loadListTransaction() -> RxSwift.Single<[TransactionLogModel]> {
        return Single.create(subscribe: { emmiter in
            
            let listData = DummyStorage.listTransaksi
            emmiter(.success(listData))
            
            return Disposables.create()
        })
    }
    
    
}
