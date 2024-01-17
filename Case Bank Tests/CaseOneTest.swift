//
//  CaseOneTest.swift
//  Case Bank Tests
//
//  Created by Jan Sebastian on 16/01/24.
//

import XCTest

final class CaseOneTest: XCTestCase {
    
    override class func setUp() {
        ServiceContainer.register(type: UserInfoDataSource.self, UserInfoDataSourceImpl())
        ServiceContainer.register(type: TransactionDataSource.self, TransactionDataSourceImpl())
    }
    
    func testCreateUserInfo() {
        let viewModel: DummyUserInfoVm<UserInfoModel> = UserInfoViewModelImpl()
        let createExpectation = expectation(description: "input success")
        
        viewModel.onSuccessInput = {
            createExpectation.fulfill()
        }
        
        viewModel.onFailed = { error in
            XCTFail("\(error)")
        }
        
        viewModel.createUser(nama: "Jan Sebastian", saldo: 500000)
        wait(for: [createExpectation], timeout: 1)
    }
    
    func testFetchUserInfo() {
        let loadExpectation = expectation(description: "should return user information")
        let viewModel: DummyUserInfoVm<UserInfoModel> = UserInfoViewModelImpl()
        viewModel.userInfo = UserInfoModel(nama: "Jan Sebastian", saldo: 500000) // inject data for testing
        
        viewModel.onSuccess = {
            if let userInfo = viewModel.userInfo {
                XCTAssertNotNil(viewModel.userInfo)
                XCTAssertEqual(userInfo.saldo, 500000, "cek saldo")
                loadExpectation.fulfill()
            } else {
                XCTFail()
            }
        }
        
        viewModel.onFailed = { error in
            XCTFail("\(error)")
        }
        viewModel.loadCurrentUser()
        wait(for: [loadExpectation], timeout: 1)
    }

    func testCreateFetchUserInfo() {
        
        let viewModel: DummyUserInfoVm<UserInfoModel> = UserInfoViewModelImpl()
        let createExpectation = expectation(description: "input success")
        let loadExpectation = expectation(description: "should return user information")
        viewModel.onSuccess = {
            if let userInfo = viewModel.userInfo {
                XCTAssertNotNil(viewModel.userInfo)
                XCTAssertEqual(userInfo.saldo, 500000, "cek saldo")
                loadExpectation.fulfill()
            } else {
                XCTFail("data kosong")
            }
        }
        
        viewModel.onSuccessInput = {
            createExpectation.fulfill()
            viewModel.loadCurrentUser()
        }
        
        viewModel.onFailed = { error in
            XCTFail("\(error)")
        }
        viewModel.createUser(nama: "Jan Sebastian", saldo: 500000)
        wait(for: [createExpectation,
                   loadExpectation], timeout: 1)
    }
    
    func testScanResultSuccess() {
        let viewModel: DummyTransactionVM<[TransactionLogModel]> = TransactionViewModelImpl()
        let input = "BNI.ID12345678.MERCHANT MOCK TEST.50000"
        
        let result = viewModel.getDetailTransaction(text: input)
        
        if let result {
            XCTAssertEqual(result.bank, "BNI", "test nama bank")
            XCTAssertEqual(result.merchanName, "MERCHANT MOCK TEST", "test merchan name")
            XCTAssertEqual(result.transactionID, "ID12345678", "test transaction id")
            XCTAssertEqual(result.price, 50000, "test harga")
        } else {
            XCTFail("data kosong")
        }
        
    }
    
    func testScanResultFailedPriceOne() {
        let viewModel: DummyTransactionVM<[TransactionLogModel]> = TransactionViewModelImpl()
        let input = "BNI.ID12345678.MERCHANT MOCK TEST."
        
        let result = viewModel.getDetailTransaction(text: input)
        
        if let result {
            XCTFail("system salah konfigurasi")
        } else {
            XCTAssertNoThrow("format input qr salah")
        }
    }
    
    func testScanResultFailedPriceTwo() {
        let viewModel: DummyTransactionVM<[TransactionLogModel]> = TransactionViewModelImpl()
        let input = "BNI.ID12345678.MERCHANT MOCK TEST.abcde"
        
        let result = viewModel.getDetailTransaction(text: input)
        
        if let result {
            XCTFail("system salah konfigurasi")
        } else {
            XCTAssertNoThrow("format input qr salah")
        }
    }
    
    func testScanResultfAILEDfoRMATsALAH() {
        let viewModel: DummyTransactionVM<[TransactionLogModel]> = TransactionViewModelImpl()
        let input = "BNI.ID12345678"
        
        let result = viewModel.getDetailTransaction(text: input)
        
        if let result {
            XCTFail("system salah konfigurasi")
        } else {
            XCTAssertNoThrow("format input qr salah")
        }
    }
    
    func testDoTransaction() {
        let viewModel: DummyTransactionVM<[TransactionLogModel]> = TransactionViewModelImpl()
        let loadExpectation = expectation(description: "should return log transaction")
        let dispatchGroup = DispatchGroup()
        viewModel.onSuccess = {
            dispatchGroup.leave()
        }
        
        viewModel.onError = { error in
            XCTFail("\(error)")
        }
        
        viewModel.onError = { error in
            XCTFail("\(error)")
        }
        
        viewModel.inputTransactionData(input: (TransactionInfoModel(bank: "BNI", transactionID: "ID12345678", merchanName: "MERCHANT MOCK TEST", price: -5000), TransactionState.Success))
        dispatchGroup.enter()
        viewModel.inputTransactionData(input: (TransactionInfoModel(bank: "BNI", transactionID: "ID12222222", merchanName: "", price: 500000), TransactionState.Success))
        dispatchGroup.enter()
        viewModel.inputTransactionData(input: (TransactionInfoModel(bank: "BNI", transactionID: "ID12345678", merchanName: "MERCHANT MOCK TEST", price: -5000), TransactionState.Failed))
        dispatchGroup.enter()
        
        dispatchGroup.notify(queue: .main, execute: {
            XCTAssertNotNil(viewModel.listTransaction, "data tidak kosong")
            if let listTransaction = viewModel.listTransaction {
                XCTAssertEqual(listTransaction.count, 3, "total transaksi")
            }
            
            loadExpectation.fulfill()
        })
        
        wait(for: [loadExpectation], timeout: 1)
    }

}
