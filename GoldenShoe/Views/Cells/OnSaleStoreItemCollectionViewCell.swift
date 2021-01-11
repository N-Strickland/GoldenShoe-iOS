//
//  OnSaleStoreItemCollectionViewCell.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 11/01/2021.
//

import UIKit

class OnSaleStoreItemCollectionViewCell: StandardStoreItemCollectionViewCell {
  // MARK: - OnSaleStoreItemCollectionViewCell Subviews
  lazy var salePriceLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .red
    label.text = "£99"
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupView() {
    contentView.addSubview(salePriceLabel)
    configureConstraints()
  }

  private func configureConstraints() {
    NSLayoutConstraint.activate([
      salePriceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 5),
      salePriceLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor)
    ])
  }
}
