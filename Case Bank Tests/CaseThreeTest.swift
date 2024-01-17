//
//  CaseThreeTest.swift
//  Case Bank Tests
//
//  Created by Jan Sebastian on 17/01/24.
//

import XCTest

final class CaseThreeTest: XCTestCase {

    override class func setUp() {
        ServiceContainer.register(type: PortoDataSource.self, PortoDataSourceImpl())
    }
    
    func testLoadPorto() {
        let viewModel: DummyPortoVM<PortofolioList> = PortofolioViewModelImpl()
        let loadExpectation = expectation(description: "should return list of promo")
        
        viewModel.onSuccess = {
            XCTAssertNotNil(viewModel.listData, "data tidak boleh kosong")
            if let listData = viewModel.listData {
                XCTAssertEqual(listData.count, 2, "jumlah data sama")
            }
            loadExpectation.fulfill()
        }
        
        viewModel.onError = { error in
            XCTFail(error.localizedDescription)
        }
        
        viewModel.loadAllData()
        wait(for: [loadExpectation], timeout: 30)
    }
}
