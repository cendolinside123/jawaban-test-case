//
//  CaseTwoTest.swift
//  Case Bank Tests
//
//  Created by Jan Sebastian on 17/01/24.
//

import XCTest

final class CaseTwoTest: XCTestCase {

    override class func setUp() {
        ServiceContainer.register(type: PromoDataSource.self, PromoDataSourceImpl())
    }
    
    func testFailLoadPromo() {
        let viewModel: DummyPromoVM<[UnknowData]> = PromoViewModelImpl()
        let loadExpectation = expectation(description: "should return list of promo")
        
        viewModel.onSuccess = {
            XCTFail("wrong confiq")
        }
        
        viewModel.onError = { error in
            XCTAssertNotEqual(error.localizedDescription, "failed load key")
            XCTAssert(true, error.localizedDescription)
            loadExpectation.fulfill()
        }
        
        viewModel.loadAllPromo()
        wait(for: [loadExpectation], timeout: 120)
    }

}
