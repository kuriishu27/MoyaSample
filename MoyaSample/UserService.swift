//
//  UserService.swift
//  MoyaSample
//
//  Created by Christian Leovido on 05/05/2021.
//

import Foundation
import Moya

enum UserService {
    case createUser(firstName: String, lastName: String)
    case updateUser(id: Int, firstName: String, lastName: String)
    case showAccounts
}

// MARK: - TargetType Protocol Implementation

extension UserService: TargetType {
    var baseURL: URL { URL(string: "https://api.myservice.com")! }
    var path: String {
        switch self {
        case .createUser:
            return "/users"
        case let .updateUser(id, _, _):
            return "/users/\(id)"
        case .showAccounts:
            return "/accounts"
        }
    }

    var method: Moya.Method {
        switch self {
        case .showAccounts:
            return .get
        case .createUser, .updateUser:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .showAccounts:
            return .requestPlain
        case let .updateUser(_, firstName, lastName):
            return .requestParameters(parameters: ["firstName": firstName, "lastName": lastName], encoding: URLEncoding.queryString)
        case let .createUser(firstName, lastName):
            return .requestParameters(parameters: ["firstName": firstName, "lastName": lastName], encoding: JSONEncoding.default)
        }
    }

    var sampleData: Data {
        switch self {
        case let .createUser(firstName, lastName):
            return "{\"id\": \(Int.random(in: 1 ... 1000)), \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\"}".utf8Encoded
        case let .updateUser(id, firstName, lastName):
            return "{\"id\": \(id), \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\"}".utf8Encoded
        case .showAccounts:
            guard let url = Bundle.main.url(forResource: "accounts", withExtension: "json"),
                  let data = try? Data(contentsOf: url)
            else {
                return Data()
            }
            return data
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

// MARK: - Helpers

private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
