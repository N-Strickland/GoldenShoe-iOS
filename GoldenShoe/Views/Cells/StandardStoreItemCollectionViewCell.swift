//
//  StandardStoreItemCollectionViewCell.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 04/01/2021.
//

import UIKit

class StandardStoreItemCollectionViewCell: UICollectionViewCell {
  // MARK: - StandardStoreItemCollectionViewCell Subviews
  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 2
    imageView.backgroundColor = .gray
    return imageView
  }()

  lazy var brandLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var shortDescriptionLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 1
    label.font = UIFont.systemFont(ofSize: 16, weight: .thin)
    return label
  }()

  lazy var priceLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var saveButton: UIButton = {
    let button = UIButton.systemButton(with: UIImage(named: "heart")!, target: nil, action: nil)
    button.tintColor = .black
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  var isFavourited: Bool = false {
    didSet {
      if isFavourited {
        saveButton.setImage(UIImage(named: "heart-filled"), for: .normal)
        saveButton.tintColor = .red
      } else {
        saveButton.setImage(UIImage(named: "heart"), for: .normal)
        saveButton.tintColor = .black
      }
    }
  }

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
    contentView.addSubview(imageView)
    contentView.addSubview(brandLabel)
    contentView.addSubview(shortDescriptionLabel)
    contentView.addSubview(saveButton)
    contentView.addSubview(priceLabel)
    configureConstraints()
  }

  private func configureConstraints() {
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 165),

      brandLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      brandLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
      brandLabel.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: 8),

      saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
      saveButton.centerYAnchor.constraint(equalTo: brandLabel.centerYAnchor),
      saveButton.widthAnchor.constraint(equalToConstant: 25),
      saveButton.heightAnchor.constraint(equalToConstant: 25),

      shortDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      shortDescriptionLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 4),
      shortDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

      priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      priceLabel.topAnchor.constraint(equalTo: shortDescriptionLabel.bottomAnchor, constant: 2),
//      priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
    ])
  }
}
