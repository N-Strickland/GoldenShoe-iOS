//
//  StandardFilterSelectView.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 09/01/2021.
//

import UIKit

final class StandardFilterSelectView: RefineBarMenuView {
  // MARK: - Lifecycle Methods
  override init(height: CGFloat, title: String, showFilterButton: Bool) {
    super.init(height: height, title: title, showFilterButton: showFilterButton)
    tableView.isScrollEnabled = true
    configureConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureConstraints() {
    NSLayoutConstraint.deactivate([
      tableView.heightAnchor.constraint(equalToConstant: 240)
    ])
//    tableView.heightAnchor.constraint(equalToConstant: 240).isActive = false
    tableView.heightAnchor.constraint(equalToConstant: 800).isActive = true
    print(tableView.constraints)
  }
}
