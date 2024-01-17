//
//  PromoDataSourceImpl.swift
//  Case Bank
//
//  Created by Jan Sebastian on 17/01/24.
//

import Foundation
import Alamofire
import RxSwift


struct PromoDataSourceImpl {
    
}

extension PromoDataSourceImpl: PromoDataSource {
    func fetchListPromo() -> RxSwift.Single<[UnknowData]> {
        return Single.create(subscribe: { emmiter in
            if let keyAuth = Bundle.main.infoDictionary?["BEARER_PROMO_KEY"] as? String {
                AF.request("https://content.digi46.id/promos", method: .get,
                           parameters: nil,
                           encoding: URLEncoding.default,
                           headers: ["Authorization": "Bearer \(keyAuth)"])
                .responseData(completionHandler: { response in
                    switch response.result {
                        
                    case .success(let data):
                        let getData = try? JSONDecoder().decode([UnknowData].self, from: data)
                        
                        if let getData {
                            emmiter(.success(getData))
                        } else {
                            do {
                                let errorData = try JSONDecoder().decode(ErrorAPI.self, from: data)
                                let errorMessage = errorData.error.message.customError()
                                emmiter(.failure(errorMessage))
                            } catch let error as NSError {
                                emmiter(.failure(error))
                            }
                        }
                        
                    case .failure(let error):
                        emmiter(.failure(error))
                    }
                })
            } else {
                emmiter(.failure("failed load key".customError()))
            }
            
            return Disposables.create()
        })
    }
    
    
}
