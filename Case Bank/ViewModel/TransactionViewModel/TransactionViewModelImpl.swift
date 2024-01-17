//
//  TransactionViewModelImpl.swift
//  Case Bank
//
//  Created by Jan Sebastian on 17/01/24.
//

import Foundation
import RxSwift


final class TransactionViewModelImpl: DummyTransactionVM<[TransactionLogModel]> {
    
    @Service private var transactionDataSource: TransactionDataSource
    private var disposeBag: DisposeBag = DisposeBag()
    
    override func getDetailTransaction(text: String) -> TransactionInfoModel? {
        
        let listInfo = text.components(separatedBy: ".")
        
        if listInfo.count < 4 {
            return nil
        }
        
        let namaBank = listInfo[0]
        let idTransaksi = listInfo[1]
        let merchanName = listInfo[2]
        let price = Int(listInfo[3])
        
        if let price {
            return TransactionInfoModel(bank: namaBank, transactionID: idTransaksi, merchanName: merchanName, price: price)
        }
        
        return nil
    }
    
    override func inputTransactionData(input: Any) {
        if let getInput = input as? (TransactionInfoModel, TransactionState) {
            onLoading?()
            
            var harga = getInput.0.price
            
            transactionDataSource
                .inputTransaction(id: UUID().uuidString, bank: getInput.0.bank, transactionID: getInput.0.transactionID, merchanName: getInput.0.merchanName, price: getInput.0.price, tanggal: Date(), status: getInput.1)
                .andThen(transactionDataSource
                    .loadListTransaction()
                )
                .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
                .map({ (listItem) -> [TransactionLogModel] in
                    let listTempItem = listItem.sorted(by: { $0.tanggal > $1.tanggal})
                    return listTempItem.reversed()
                })
                .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
                .observe(on: MainScheduler.instance)
                .subscribe(onSuccess: { [weak self] listData in
                    self?.listTransaction = listData
                    self?.onSuccess?()
                }).disposed(by: disposeBag)
            
        }
    }
    
    override func getAllLogTransaction() {
        onLoading?()
        transactionDataSource
            .loadListTransaction()
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .map({ (listItem) -> [TransactionLogModel] in
                let listTempItem = listItem.sorted(by: { $0.tanggal > $1.tanggal})
                return listTempItem.reversed()
            })
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] listData in
                self?.listTransaction = listData
                self?.onSuccess?()
            }).disposed(by: disposeBag)
    }
}
