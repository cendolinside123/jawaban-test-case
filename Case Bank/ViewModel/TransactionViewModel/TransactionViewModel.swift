//
//  TransactionViewModel.swift
//  Case Bank
//
//  Created by Jan Sebastian on 17/01/24.
//

import Foundation

protocol TransactionViewModel {
    associatedtype TransactionLogType
    associatedtype TransactionInfoType
    var listTransaction: TransactionLogType? { get set }
    var onLoading: (() -> Void)? { get set }
    var onSuccess: (() -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    func getDetailTransaction(text: String) -> TransactionInfoType?
    func getAllLogTransaction()
    func inputTransactionData(input: Any)
}


class DummyTransactionVM<T>: TransactionViewModel {
    typealias TransactionLogType = T
    typealias TransactionInfoType = TransactionInfoModel
    var listTransaction: T?
    var onLoading: (() -> Void)?
    var onSuccess: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    func getDetailTransaction(text: String) -> TransactionInfoModel? {
        return nil
    }
    
    func getAllLogTransaction() {
        
    }
    
    func inputTransactionData(input: Any) {
        
    }
}
