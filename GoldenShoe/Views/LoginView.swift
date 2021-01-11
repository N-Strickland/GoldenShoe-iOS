//
//  LoginView.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 01/01/2021.
//

import UIKit

final class LoginView: UIView {
  // MARK: - LoginView Subviews
  private lazy var loginTitleText: UILabel = {
    let label = UILabel()
    label.font = UIStyle.Fonts.titleFont
    label.textColor = UIStyle.Colors.titleTextColor
    label.text = "Log In"
    return label
  }()

  lazy var backButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIStyle.Icons.backArrowIcon, for: .normal)
    button.tintColor = UIStyle.Colors.backButtonFill
    return button
  }()

  lazy var emailTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "E-mail Address"
    textField.textContentType = .emailAddress
    textField.layer.cornerRadius = 55/2
    textField.layer.borderWidth = 1.0
    textField.setPaddingFor(left: 20, right: nil)
    textField.font = UIStyle.Fonts.primaryFont
    textField.textColor = UIStyle.Colors.textFieldColor
    textField.backgroundColor = UIStyle.Colors.textFieldFill
    textField.clipsToBounds = true

    return textField
  }()

  lazy var passwordTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Password"
    textField.textContentType = .password
    textField.isSecureTextEntry = true
    textField.layer.cornerRadius = 55/2
    textField.layer.borderWidth = 1.0
    textField.font = UIStyle.Fonts.primaryFont
    textField.textColor = UIStyle.Colors.textFieldColor
    textField.backgroundColor = UIStyle.Colors.textFieldFill
    textField.setPaddingFor(left: 20, right: nil)
    textField.clipsToBounds = true
    return textField
  }()

  lazy var loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Log In", for: .normal)
    button.setTitleColor(UIStyle.Colors.mainTextColor, for: .normal)
    button.titleLabel?.font = UIStyle.Fonts.controlFont
    button.backgroundColor = UIStyle.Colors.buttonFill
    button.layer.borderColor = UIStyle.Colors.buttonBorder.cgColor
    button.layer.cornerRadius = 8
    button.layer.borderWidth = 1
    return button
  }()

  // MARK: - Lifecycle Methods
  convenience init() {
    self.init(frame: .zero)
    setupView()
  }

  // MARK: - Helper Methods
  private func setupView() {
    backgroundColor = .systemBackground
    setupViewsForAutoLayout(views: [
                              loginTitleText,
                              backButton,
                              emailTextField,
                              passwordTextField,
                              loginButton])
    configureConstraints()
  }

  private func configureConstraints() {
    NSLayoutConstraint.activate([
      backButton.widthAnchor.constraint(equalToConstant: 25),
      backButton.heightAnchor.constraint(equalToConstant: 25),
      backButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      backButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),

      loginTitleText.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 50),
      loginTitleText.leadingAnchor.constraint(
        equalTo: layoutMarginsGuide.leadingAnchor,
        constant: 20),

      emailTextField.heightAnchor.constraint(equalToConstant: 55),
      emailTextField.topAnchor.constraint(
        equalTo: loginTitleText.bottomAnchor,
        constant: 40),
      emailTextField.leadingAnchor.constraint(
        equalTo: layoutMarginsGuide.leadingAnchor,
        constant: 25),
      emailTextField.trailingAnchor.constraint(
        equalTo: layoutMarginsGuide.trailingAnchor,
        constant: -25),

      passwordTextField.heightAnchor.constraint(equalToConstant: 55),
      passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24),
      passwordTextField.leadingAnchor.constraint(
        equalTo: layoutMarginsGuide.leadingAnchor,
        constant: 25),
      passwordTextField.trailingAnchor.constraint(
        equalTo: layoutMarginsGuide.trailingAnchor,
        constant: -25),

      loginButton.heightAnchor.constraint(equalToConstant: 55),
      loginButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 50),
      loginButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -50),
      loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30)
    ])
  }
}
