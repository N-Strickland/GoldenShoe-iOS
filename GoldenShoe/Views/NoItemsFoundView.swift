//
//  NoItemsFoundCollectionViewCell.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 07/01/2021.
//

import UIKit

final class NoItemsFoundView: UIView {
  // MARK: - NoItemsFoundView Subviews
  private lazy var noItemsLabel: UILabel = {
    let label = UILabel()
    label.text = "No Items Found"
    label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    label.textColor = .lightGray
    label.textAlignment = .center
    return label
  }()

  // MARK: - Lifecycle Methods
  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Helper Methods
  private func setupView() {
    backgroundColor = .clear
    setupViewForAutoLayout(view: noItemsLabel)
    configureConstraints()
  }

  private func configureConstraints() {
    NSLayoutConstraint.activate([
      noItemsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      noItemsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      noItemsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15)
    ])
  }
}
