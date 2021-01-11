//
//  StandardFilterSelectionCell.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 09/01/2021.
//

import UIKit

class StandardFilterSelectionCell: UITableViewCell {
  // MARK: - StandardFilterSelectionCell Subviews
  lazy var itemLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 17)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var detailLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 17)
    label.textColor = .systemGray
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.text = "(x)"
    return label
  }()

  // MARK: - Instance Properties
  var isChecked: Bool = false {
    didSet {
      accessoryType = isChecked ? .checkmark : .none
    }
  }

  // MARK: - Lifecycle Methods
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Helper Methods
  private func setupView() {
    separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    backgroundColor = .white
    contentView.addSubview(itemLabel)
    contentView.addSubview(detailLabel)
    configureConstraints()
  }

  private func configureConstraints() {
    NSLayoutConstraint.activate([
      itemLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
      itemLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
      itemLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
      itemLabel.heightAnchor.constraint(equalToConstant: 30),

      detailLabel.centerYAnchor.constraint(equalTo: itemLabel.centerYAnchor),
      detailLabel.leadingAnchor.constraint(equalTo: itemLabel.trailingAnchor, constant: 10)
    ])
  }
}
