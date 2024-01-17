//
//  PortofolioViewModelImpl.swift
//  Case Bank
//
//  Created by Jan Sebastian on 17/01/24.
//

import Foundation
import RxSwift

final class PortofolioViewModelImpl: DummyPortoVM<PortofolioList> {
    
    @Service private var portoUseCase: PortoDataSource
    private var disposeBag: DisposeBag = DisposeBag()
    
    override func loadAllData() {
        onLoading?()
        
        portoUseCase
            .loadAllData()
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] listData in
                self?.listData = listData
                self?.onSuccess?()
            }, onFailure: { [weak self] error in
                self?.onError?(error)
            }).disposed(by: disposeBag)
    }
    
}
