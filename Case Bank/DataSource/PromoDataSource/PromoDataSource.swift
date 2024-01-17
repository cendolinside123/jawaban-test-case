//
//  PromoDataSource.swift
//  Case Bank
//
//  Created by Jan Sebastian on 17/01/24.
//

import Foundation
import RxSwift


protocol PromoDataSource {
    func fetchListPromo() -> Single<[UnknowData]>
}
