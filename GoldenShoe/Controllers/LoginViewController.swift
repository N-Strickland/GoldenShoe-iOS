//
//  LoginViewController.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 01/01/2021.
//

import UIKit

final class LoginViewController: UIViewController {
  // MARK: - View Outlets
  private lazy var rootView = LoginView()
  private unowned var backButton: UIButton { rootView.backButton }

  // MARK: - Lifecycle Methods
  override func loadView() {
    view = rootView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
  }

  // MARK: - Actions
  @objc func backButtonPressed() {
    navigationController?.popViewController(animated: true)
  }
}
