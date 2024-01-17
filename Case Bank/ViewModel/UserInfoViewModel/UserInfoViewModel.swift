//
//  UserInfoViewModel.swift
//  Case Bank
//
//  Created by Jan Sebastian on 16/01/24.
//

import Foundation

protocol UserInfoViewModel {
    associatedtype UserData
    
    var userInfo: UserData? { get set }
    
    var onLoading: (() -> Void)? { get set }
    var onSuccess: (() -> Void)? { get set }
    var onSuccessInput: (() -> Void)? { get set }
    var onSuccessUpdate: (() -> Void)? { get set }
    var onFailed: ((Error) -> Void)? { get set }
    
    func createUser(nama: String, saldo: Int)
    func updateSaldo(bayar harga: Int)
    func updateSaldo(topup harga: Int)
    func loadCurrentUser()
}

class DummyUserInfoVm<T>: UserInfoViewModel {
    typealias UserData = T
    var userInfo: T?
    
    var onLoading: (() -> Void)?
    
    var onSuccess: (() -> Void)?
    
    var onSuccessInput: (() -> Void)?
    
    var onSuccessUpdate: (() -> Void)?
    
    var onFailed: ((Error) -> Void)?
    
    func createUser(nama: String, saldo: Int) {
        
    }
    
    func updateSaldo(bayar harga: Int) {
        
    }
    
    func updateSaldo(topup harga: Int) {
        
    }
    
    func loadCurrentUser() {
        
    }
}
