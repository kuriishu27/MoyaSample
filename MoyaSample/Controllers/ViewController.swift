//
//  ViewController.swift
//  MoyaSample
//
//  Created by Christian Leovido on 05/05/2021.
//

import Moya
import UIKit

final class ViewController: UIViewController {
    let viewModel = UserViewModel()
    var accounts: [Account]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_: Bool) {
        viewModel.showAccounts { result in
            switch result {
            case let .failure(error):
                // handle error via a logger, alert, etc.
                print(error.errorDescription!)
            case let .success(account):
                self.accounts = account
            }
        }
    }
}
