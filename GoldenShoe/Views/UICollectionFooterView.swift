//
//  UICollectionFooterView.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 05/01/2021.
//

import UIKit

class UICollectionFooterView: UICollectionReusableView {
  // MARK: - UICollectionFooterView Subviews
  lazy var returnToTopButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Return to Top", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = UIColor(red: 47/255, green: 51/255, blue: 48/255, alpha: 1)
    button.layer.cornerRadius = 5
    button.layer.masksToBounds = false
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOffset = CGSize(width: 0, height: 0)
    button.layer.shadowRadius = 1
    button.layer.shadowOpacity = 0.5
    return button
  }()

  // MARK: - Lifecycle Methods
  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Helper Methods
  private func setupViews() {
    setupViewForAutoLayout(view: returnToTopButton)
    configureConstraints()
  }

  private func configureConstraints() {
    NSLayoutConstraint.activate([
      returnToTopButton.leadingAnchor.constraint(equalTo: leadingAnchor),
      returnToTopButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      returnToTopButton.heightAnchor.constraint(equalToConstant: 40),
      returnToTopButton.topAnchor.constraint(equalTo: topAnchor, constant: 15)
    ])
  }
}
