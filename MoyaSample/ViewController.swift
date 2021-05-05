//
//  ViewController.swift
//  MoyaSample
//
//  Created by Christian Leovido on 05/05/2021.
//

import UIKit
import Moya

final class ViewController: UIViewController {

	let viewModel: ViewModel = ViewModel()
	var accounts: [Account]!

	override func viewDidLoad() {
		super.viewDidLoad()

	}

	override func viewDidAppear(_ animated: Bool) {
		viewModel.showAccounts { result in
			switch result {
			case .failure(let error):
				// handle error via a logger, alert, etc.
				print(error.errorDescription!)
			case .success(let account):
				self.accounts = account
			}
		}
	}
}
