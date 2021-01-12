//
//  PriceFilterConfigCell.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 10/01/2021.
//

import UIKit
import RangeSeekSlider

final class PriceFilterConfigCell: UITableViewCell {
  // MARK: - PriceFilterConfigCell Subviews
  lazy var priceRange: RangeSeekSlider = {
    let slider = RangeSeekSlider()
    slider.handleColor = .black
    slider.colorBetweenHandles = .systemGray
    slider.tintColor = .systemGray6
    slider.handleDiameter = 25
    slider.lineHeight = 3
    slider.selectedHandleDiameterMultiplier = 1.3
    slider.minLabelFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
    slider.maxLabelFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
    slider.maxLabelColor = .black
    slider.minLabelColor = .black
    slider.labelPadding = -55
    slider.step = 1
    slider.translatesAutoresizingMaskIntoConstraints = false
    return slider
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
    backgroundColor = .white
    selectionStyle = .none
    contentView.addSubview(priceRange)
    configureConstraints()
  }

  private func configureConstraints() {
    NSLayoutConstraint.activate([
      priceRange.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
      priceRange.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
      priceRange.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 15),
      priceRange.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
    ])

  }
}
