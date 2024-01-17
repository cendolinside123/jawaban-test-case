//
//  PromoViewModelImpl.swift
//  Case Bank
//
//  Created by Jan Sebastian on 17/01/24.
//

import Foundation
import RxSwift

final class PromoViewModelImpl: DummyPromoVM<[UnknowData]> {
    @Service private var promoDataSource: PromoDataSource
    private var disposeBag: DisposeBag = DisposeBag()
    
    override func loadAllPromo() {
        onLoading?()
        
        promoDataSource
            .fetchListPromo()
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] listData in
                self?.listPromo = listData
                self?.onSuccess?()
            }, onFailure: { [weak self] error in
                self?.onError?(error)
            }).disposed(by: disposeBag)
    }
    
}
