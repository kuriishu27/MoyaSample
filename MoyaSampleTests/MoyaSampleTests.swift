//
//  MoyaSampleTests.swift
//  MoyaSampleTests
//
//  Created by Christian Leovido on 05/05/2021.
//

import Moya
@testable import MoyaSample
import XCTest

class MoyaSampleTests: XCTestCase {
    var viewModel: UserViewModel!

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testCreateUser() throws {
        let exp = expectation(description: "creates a new user")

        viewModel = UserViewModel(provider: MoyaProvider<UserService>(stubClosure: MoyaProvider.immediatelyStub))

        viewModel.createUser(firstName: "Fancy", lastName: "Name") { result in
            switch result {
            case let .failure(error):
                XCTFail(error.localizedDescription)
            case let .success(user):
                XCTAssertEqual(user.firstName, "Fancy")
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func testUpdateUser() throws {
        let exp = expectation(description: "updates a new user")

        viewModel = UserViewModel(provider: MoyaProvider<UserService>(stubClosure: MoyaProvider.immediatelyStub))

        viewModel.updateUser(id: 123, firstName: "Updated", lastName: "Last Name") { result in
            switch result {
            case let .failure(error):
                XCTFail(error.localizedDescription)
            case let .success(user):
                XCTAssertEqual(user.firstName, "Updated")
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }

    func testShowAccounts() throws {
        let exp = expectation(description: "updates a new user")

        viewModel = UserViewModel(provider: MoyaProvider<UserService>(stubClosure: MoyaProvider.immediatelyStub))

        viewModel.showAccounts { result in
            switch result {
            case let .failure(error):
                XCTFail(error.localizedDescription)
            case let .success(accounts):
                XCTAssertEqual(accounts.first!.userId, 123)
                exp.fulfill()
            }
        }
        wait(for: [exp], timeout: 1)
    }
}
