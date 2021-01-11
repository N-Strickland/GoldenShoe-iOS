//
//  UIView+SetupAutoLayout.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 01/01/2021.
//

import UIKit

extension UIView {
  func setupViewForAutoLayout(view: UIView) {
    view.translatesAutoresizingMaskIntoConstraints = false
    addSubview(view)
  }

  func setupViewsForAutoLayout(views: [UIView]) {
    for view in views {
      setupViewForAutoLayout(view: view)
    }
  }
}
