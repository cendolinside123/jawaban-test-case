//
//  UserInfoViewModelImpl.swift
//  Case Bank
//
//  Created by Jan Sebastian on 16/01/24.
//

import Foundation
import RxSwift

final class UserInfoViewModelImpl: DummyUserInfoVm<UserInfoModel> {
    
    @Service private var userInfoUseCase: UserInfoDataSource
    
    private var disposeBag: DisposeBag = DisposeBag()
    
    override func loadCurrentUser() {
        onLoading?()
        userInfoUseCase
            .getUserInfo()
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] result in
                self?.userInfo = result
                self?.onSuccess?()
            })
            .disposed(by: disposeBag)
        
    }
    
    override func createUser(nama: String, saldo: Int) {
        onLoading?()
        userInfoUseCase
            .createUser(nama: nama, saldo: saldo)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onCompleted: { [weak self] in
                self?.onSuccessInput?()
            })
            .disposed(by: disposeBag)
        
    }
    
    override func updateSaldo(bayar harga: Int) {
        onLoading?()
        
        userInfoUseCase
            .getUserInfo()
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .flatMap({ [weak self] result in
                guard let superSelf = self else {
                    throw "unknow Error".customError()
                }
                if result.saldo >= harga {
                    return superSelf.userInfoUseCase
                        .updateUser(nama: result.nama, saldo: (result.saldo - harga))
                        .andThen(Single.just(()))
                } else {
                    throw "harga melebihi saldo".customError()
                }
                
            })
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .flatMap({ [weak self] _ in
                guard let superSelf = self else {
                    throw "unknow Error".customError()
                }
                return superSelf.userInfoUseCase.getUserInfo()
            })
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.instance)
                .subscribe(onSuccess: { [weak self] result in
                    self?.userInfo = result
                    self?.onSuccessUpdate?()
                }, onFailure: { [weak self] error in
                    self?.onFailed?(error)
                }).disposed(by: disposeBag)
        
    }
    
    override func updateSaldo(topup harga: Int) {
        onLoading?()
        
        userInfoUseCase
            .getUserInfo()
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .flatMap({ [weak self] result in
                guard let superSelf = self else {
                    throw "unknow Error".customError()
                }
                return superSelf.userInfoUseCase
                    .updateUser(nama: result.nama, saldo: (result.saldo + harga))
                    .andThen(Single.just(()))
                
            })
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .flatMap({ [weak self] _ in
                guard let superSelf = self else {
                    throw "unknow Error".customError()
                }
                return superSelf.userInfoUseCase.getUserInfo()
            })
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] result in
                self?.userInfo = result
                self?.onSuccessUpdate?()
            }, onFailure: { [weak self] error in
                self?.onFailed?(error)
            }).disposed(by: disposeBag)
    }
    
}
