//
//  UserInfoDataSourceImpl.swift
//  Case Bank
//
//  Created by Jan Sebastian on 16/01/24.
//

import Foundation
import RxSwift

struct UserInfoDataSourceImpl {
    
}

extension UserInfoDataSourceImpl: UserInfoDataSource {
    func createUser(nama: String, saldo: Int) -> RxSwift.Completable {
        return Completable.create(subscribe: { emmiter in
            DummyStorage.userInformation  = UserInfoModel(nama: nama, saldo: saldo)
            emmiter(.completed)
            return Disposables.create()
        })
    }
    
    func updateUser(nama: String, saldo: Int) -> RxSwift.Completable {
        return Completable.create(subscribe: { emmiter in
            DummyStorage.userInformation  = UserInfoModel(nama: nama, saldo: saldo)
            emmiter(.completed)
            return Disposables.create()
        })
    }
    
    func getUserInfo() -> RxSwift.Single<UserInfoModel> {
        return Single.create(subscribe: { emmiter in
            if let userInfo = DummyStorage.userInformation {
                emmiter(.success(userInfo))
            } else {
                emmiter(.failure("gagal memperoleh informasi user".customError()))
            }
            return Disposables.create()
        })
    }
    
    
}
