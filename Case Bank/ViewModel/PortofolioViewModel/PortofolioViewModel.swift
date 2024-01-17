//
//  PortofolioViewModel.swift
//  Case Bank
//
//  Created by Jan Sebastian on 17/01/24.
//

import Foundation

protocol PortofolioViewModel {
    associatedtype ProtofolioDataType
    
    var listData: ProtofolioDataType? { get set }
    var onLoading: (() -> Void)? { get set }
    var onSuccess: (() -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    
    func loadAllData()
}

class DummyPortoVM<T>: PortofolioViewModel {
    typealias ProtofolioDataType = T
    var listData: T?
    
    var onLoading: (() -> Void)?
    
    var onSuccess: (() -> Void)?
    
    var onError: ((Error) -> Void)?
    
    func loadAllData() {
        
    }
}
