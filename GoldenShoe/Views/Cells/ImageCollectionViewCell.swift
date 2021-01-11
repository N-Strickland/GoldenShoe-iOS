//
//  ImageCollectionViewCell.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 02/01/2021.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
  // MARK: - ImageCollectionViewCell Subviews
  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 2
    return imageView
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
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 0)
    layer.shadowRadius = 1
    layer.shadowOpacity = 0.5
//    layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath

    contentView.addSubview(imageView)
    configureConstraints()
  }

  private func configureConstraints() {
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }
}
