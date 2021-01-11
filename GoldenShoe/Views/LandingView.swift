//
//  LandingView.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 01/01/2021.
//

import UIKit

final class LandingView: UIView {
  // MARK: - Subviews
  private lazy var logoImageView: UIImageView = {
    let imageView = UIImageView()
    let logo = UIImage(named: Assets.Images.companyLogo)!
    imageView.image = logo
    return imageView
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIStyle.Fonts.titleFont
    label.text = "Golden Shoe"
    return label
  }()

  private lazy var subtitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIStyle.Fonts.primaryFont
    label.text =  """
    Shop for new shoes and get updates on new products, promotions and sales!
    """
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()

  lazy var loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Log In", for: .normal)
    button.setTitleColor(UIStyle.Colors.mainTextColor, for: .normal)
    button.titleLabel?.font = UIStyle.Fonts.controlFont
    button.backgroundColor = UIStyle.Colors.elementFill
    button.layer.borderColor = UIStyle.Colors.elementFill.cgColor
    button.layer.cornerRadius = 55/2
    button.layer.borderWidth = 1
    return button
  }()

  lazy var signupButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign Up", for: .normal)
    button.setTitleColor(UIStyle.Colors.mainTextColor, for: .normal)
    button.titleLabel?.font = UIStyle.Fonts.controlFont
    button.layer.borderColor = UIStyle.Colors.elementFill.cgColor
    button.layer.cornerRadius = 55/2
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

    setupViewsForAutoLayout(
      views: [logoImageView, titleLabel, subtitleLabel, loginButton, signupButton])
    configureConstraints()
  }

  private func configureConstraints() {
    NSLayoutConstraint.activate([
      logoImageView.widthAnchor.constraint(equalToConstant: 120),
      logoImageView.heightAnchor.constraint(equalToConstant: 120),
      logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      logoImageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 100),

      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),

      subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      subtitleLabel.leadingAnchor.constraint(
        greaterThanOrEqualTo: layoutMarginsGuide.leadingAnchor,
        constant: 20),
      subtitleLabel.trailingAnchor.constraint(
        greaterThanOrEqualTo: layoutMarginsGuide.trailingAnchor,
        constant: -20),
      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 23),

      loginButton.heightAnchor.constraint(equalToConstant: 55),
      loginButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 50),
      loginButton.trailingAnchor.constraint(
        equalTo: layoutMarginsGuide.trailingAnchor,
        constant: -50),
      loginButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 45),

      signupButton.heightAnchor.constraint(equalToConstant: 55),
      signupButton.leadingAnchor.constraint(
        equalTo: layoutMarginsGuide.leadingAnchor,
        constant: 50),
      signupButton.trailingAnchor.constraint(
        equalTo: layoutMarginsGuide.trailingAnchor,
        constant: -50),
      signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 23)
    ])
  }
}
