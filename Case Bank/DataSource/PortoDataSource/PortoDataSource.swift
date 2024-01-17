//
//  PortoDataSource.swift
//  Case Bank
//
//  Created by Jan Sebastian on 17/01/24.
//

import Foundation
import RxSwift

protocol PortoDataSource {
    func loadAllData() -> Single<PortofolioList>
}
