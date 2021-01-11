//
//  LandingViewController.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 01/01/2021.
//

import UIKit

final class LandingViewController: UIViewController {
  // MARK: - View Outlets
  private lazy var rootView = LandingView()
  private unowned var loginButton: UIButton { rootView.loginButton }
  private unowned var signUpButton: UIButton { rootView.signupButton }

  // MARK: - Lifecycle Methods
  override func loadView() {
    view = rootView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    navigationController?.isNavigationBarHidden = true
  }

  // MARK: - Actions
  @objc func loginButtonPressed() {
    let loginViewController = LoginViewController()
    navigationController?.pushViewController(loginViewController, animated: true)
  }

  @objc func signUpButtonPressed() {
    let signUpViewController = SignUpViewController()
    navigationController?.pushViewController(signUpViewController, animated: true)
  }
}
