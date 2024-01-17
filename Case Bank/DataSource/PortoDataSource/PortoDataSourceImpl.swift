//
//  PortoDataSourceImpl.swift
//  Case Bank
//
//  Created by Jan Sebastian on 17/01/24.
//

import Foundation
import RxSwift

struct PortoDataSourceImpl {
    
}

extension PortoDataSourceImpl: PortoDataSource {
    func loadAllData() -> RxSwift.Single<PortofolioList> {
        return Single.create(subscribe: { emmiter in
            
            if let file = Bundle.main.path(forResource: "Chart", ofType: "json") {
                var url: URL?
                
                if #available(iOS 16.0, *) {
                    url = URL(filePath: file)
                } else {
                    // Fallback on earlier versions
                    url = URL(fileURLWithPath: file)
                }
                
                if let url {
                    do {
                        let convertToData = try Data(contentsOf: url, options: .mappedIfSafe)
                        let getResult = try JSONDecoder().decode(PortofolioList.self, from: convertToData)
                        emmiter(.success(getResult))
                    } catch let error as NSError {
                        emmiter(.failure(error))
                    }
                } else {
                    emmiter(.failure("error get url".customError()))
                }
                
            } else {
                emmiter(.failure("File not found".customError()))
            }
            
            return Disposables.create()
        })
    }
    
    
}
