//
//  DynamicTableView.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 09/01/2021.
//

import UIKit

class DynamicTableView: UITableView {
  override var intrinsicContentSize: CGSize {
    return contentSize
  }

  override public func layoutSubviews() {
      super.layoutSubviews()
      if bounds.size != intrinsicContentSize {
          invalidateIntrinsicContentSize()
      }
  }
}
