//
//  UserInfoDataSource.swift
//  Case Bank
//
//  Created by Jan Sebastian on 16/01/24.
//

import Foundation
import RxSwift

protocol UserInfoDataSource {
    func createUser(nama: String, saldo: Int) -> Completable
    func updateUser(nama: String, saldo: Int) -> Completable
    func getUserInfo() -> Single<UserInfoModel>
}
