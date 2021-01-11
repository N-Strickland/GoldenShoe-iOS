//
//  SortOptionTableViewCell.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 08/01/2021.
//

import UIKit

final class SortOptionTableViewCell: UITableViewCell {
  // MARK: - SortOptionTableViewCell Subviews
  lazy var myImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "dry-clean")?.withTintColor(.systemGray3)
    imageView.tintColor = .red
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  lazy var myTextLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 17)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  // MARK: - Instance Properties
  var isChosen: Bool = false {
    didSet {
      myImageView.image = isChosen ? UIImage(named: "verified")?.withTintColor(.systemGray3) :
        UIImage(named: "dry-clean")?.withTintColor(.systemGray3)
      myTextLabel.textColor = isChosen ? .systemGray3 : .black
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
    selectionStyle = .none
    contentView.addSubview(myImageView)
    contentView.addSubview(myTextLabel)
    configureConstraints()
  }

  private func configureConstraints() {
    NSLayoutConstraint.activate([
      myImageView.heightAnchor.constraint(equalToConstant: 20),
      myImageView.widthAnchor.constraint(equalToConstant: 20),
      myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      myImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

      myTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      myTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      myTextLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 20),
      myTextLabel.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
}
