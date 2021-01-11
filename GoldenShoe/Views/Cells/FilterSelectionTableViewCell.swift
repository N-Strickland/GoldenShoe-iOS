//
//  FilterSelectionTableViewCell.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 09/01/2021.
//

import UIKit

final class FilterSelectionTableViewCell: UITableViewCell {
  // MARK: - FilterSelectionTableViewCell Subviews
  lazy var filterLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 17)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    return label
  }()

  lazy var detailLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 17)
    label.textColor = .systemGray
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .right
    label.text = "All"
    return label
  }()

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
    contentView.addSubview(filterLabel)
    contentView.addSubview(detailLabel)
    configureConstraints()
  }

  private func configureConstraints() {
    NSLayoutConstraint.activate([
      filterLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
      filterLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
      filterLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
      filterLabel.heightAnchor.constraint(equalToConstant: 30),

      detailLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
      detailLabel.centerYAnchor.constraint(equalTo: filterLabel.centerYAnchor),
      detailLabel.widthAnchor.constraint(equalToConstant: 280)
    ])
  }
}
