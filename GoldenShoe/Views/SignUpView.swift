//
//  SignUpView.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 02/01/2021.
//

import UIKit

final class SignUpView: UIView {
  // MARK: - LoginView Subviews
  private lazy var signUpTitleText: UILabel = {
    let label = UILabel()
    label.font = UIStyle.Fonts.titleFont
    label.textColor = UIStyle.Colors.titleTextColor
    label.text = "Sign Up"
    return label
  }()

  lazy var backButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIStyle.Icons.backArrowIcon, for: .normal)
    button.tintColor = UIStyle.Colors.backButtonFill
    return button
  }()

  lazy var nameTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Full Name"
    textField.textContentType = .emailAddress
    textField.layer.cornerRadius = 40/2
    textField.layer.borderWidth = 1.0
    textField.setPaddingFor(left: 20, right: nil)
    textField.font = UIStyle.Fonts.primaryFont
    textField.textColor = UIStyle.Colors.textFieldColor
    textField.backgroundColor = UIStyle.Colors.textFieldFill
    textField.clipsToBounds = true

    return textField
  }()

  lazy var phoneNumberTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Phone Number"
    textField.textContentType = .telephoneNumber
    textField.layer.cornerRadius = 40/2
    textField.layer.borderWidth = 1.0
    textField.font = UIStyle.Fonts.primaryFont
    textField.textColor = UIStyle.Colors.textFieldColor
    textField.backgroundColor = UIStyle.Colors.textFieldFill
    textField.setPaddingFor(left: 20, right: nil)
    textField.clipsToBounds = true
    return textField
  }()

  lazy var emailAddressTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "E-mail Address"
    textField.textContentType = .emailAddress
    textField.layer.cornerRadius = 40/2
    textField.layer.borderWidth = 1.0
    textField.font = UIStyle.Fonts.primaryFont
    textField.textColor = UIStyle.Colors.textFieldColor
    textField.backgroundColor = UIStyle.Colors.textFieldFill
    textField.setPaddingFor(left: 20, right: nil)
    textField.clipsToBounds = true
    return textField
  }()

  lazy var passwordTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Password"
    textField.textContentType = .password
    textField.layer.cornerRadius = 40/2
    textField.layer.borderWidth = 1.0
    textField.font = UIStyle.Fonts.primaryFont
    textField.textColor = UIStyle.Colors.textFieldColor
    textField.backgroundColor = UIStyle.Colors.textFieldFill
    textField.setPaddingFor(left: 20, right: nil)
    textField.clipsToBounds = true
    textField.isSecureTextEntry = true
    return textField
  }()

  lazy var signUpButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign Up", for: .normal)
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
                              signUpTitleText,
                              backButton,
                              nameTextField,
                              phoneNumberTextField,
                              emailAddressTextField,
                              passwordTextField,
                              signUpButton])
    configureConstraints()
  }

  // swiftlint:disable:next function_body_length
  private func configureConstraints() {
    NSLayoutConstraint.activate([
      backButton.widthAnchor.constraint(equalToConstant: 25),
      backButton.heightAnchor.constraint(equalToConstant: 25),
      backButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      backButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),

      signUpTitleText.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 50),
      signUpTitleText.leadingAnchor.constraint(
        equalTo: layoutMarginsGuide.leadingAnchor,
        constant: 20),

      nameTextField.heightAnchor.constraint(equalToConstant: 40),
      nameTextField.topAnchor.constraint(
        equalTo: signUpTitleText.bottomAnchor,
        constant: 40),
      nameTextField.leadingAnchor.constraint(
        equalTo: layoutMarginsGuide.leadingAnchor,
        constant: 40),
      nameTextField.trailingAnchor.constraint(
        equalTo: layoutMarginsGuide.trailingAnchor,
        constant: -40),

      phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40),
      phoneNumberTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
      phoneNumberTextField.leadingAnchor.constraint(
        equalTo: layoutMarginsGuide.leadingAnchor,
        constant: 40),
      phoneNumberTextField.trailingAnchor.constraint(
        equalTo: layoutMarginsGuide.trailingAnchor,
        constant: -40),

      emailAddressTextField.heightAnchor.constraint(equalToConstant: 40),
      emailAddressTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
      emailAddressTextField.leadingAnchor.constraint(
        equalTo: layoutMarginsGuide.leadingAnchor,
        constant: 40),
      emailAddressTextField.trailingAnchor.constraint(
        equalTo: layoutMarginsGuide.trailingAnchor,
        constant: -40),

      passwordTextField.heightAnchor.constraint(equalToConstant: 40),
      passwordTextField.topAnchor.constraint(equalTo: emailAddressTextField.bottomAnchor, constant: 20),
      passwordTextField.leadingAnchor.constraint(
        equalTo: layoutMarginsGuide.leadingAnchor,
        constant: 40),
      passwordTextField.trailingAnchor.constraint(
        equalTo: layoutMarginsGuide.trailingAnchor,
        constant: -40),

      signUpButton.heightAnchor.constraint(equalToConstant: 40),
      signUpButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 50),
      signUpButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -50),
      signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30)
    ])
  }
}
