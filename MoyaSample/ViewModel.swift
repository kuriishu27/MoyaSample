//
//  ViewModel.swift
//  MoyaSample
//
//  Created by Christian Leovido on 05/05/2021.
//

import Foundation
import Moya

final class ViewModel {
    let provider: MoyaProvider<UserService>

    init(provider: MoyaProvider<UserService> = MoyaProvider<UserService>()) {
        self.provider = provider
    }

    func createUser(firstName: String, lastName: String, completion: @escaping (Result<User, MoyaError>) -> Void) {
        provider.request(.createUser(firstName: firstName, lastName: lastName)) { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(response):
                guard let response = try? response.filter(statusCodes: 200 ..< 399) else {
                    return
                }

                let model = try! JSONDecoder().decode(User.self, from: response.data)

                completion(.success(model))
            }
        }
    }

    func updateUser(id: Int, firstName: String, lastName: String, completion: @escaping (Result<User, MoyaError>) -> Void) {
        provider.request(.updateUser(id: id, firstName: firstName, lastName: lastName)) { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(response):
                guard let response = try? response.filter(statusCodes: 200 ..< 399) else {
                    return
                }

                let model = try! JSONDecoder().decode(User.self, from: response.data)

                completion(.success(model))
            }
        }
    }

    func showAccounts(completion: @escaping (Result<[Account], MoyaError>) -> Void) {
        provider.request(.showAccounts) { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(response):
                guard let response = try? response.filter(statusCodes: 200 ..< 399) else {
                    return
                }

                let models = try! JSONDecoder().decode([Account].self, from: response.data)

                completion(.success(models))
            }
        }
    }
}
