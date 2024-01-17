//
//  PromoViewModel.swift
//  Case Bank
//
//  Created by Jan Sebastian on 17/01/24.
//

import Foundation
import RxSwift

protocol PromoViewModel {
    associatedtype PromoTypeData
    
    var listPromo: PromoTypeData? { get set }
    var onLoading: (() -> Void)? { get set }
    var onSuccess: (() -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    
    func loadAllPromo()
}

class DummyPromoVM<T>: PromoViewModel {
    typealias PromoTypeData = T
    var listPromo: T?
    
    var onLoading: (() -> Void)?
    
    var onSuccess: (() -> Void)?
    
    var onError: ((Error) -> Void)?
    
    func loadAllPromo() {
        
    }
    
}
