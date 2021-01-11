//
//  UITextField+SetContentPadding.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 01/01/2021.
//

import UIKit

extension UITextField {
  func setPaddingFor(left: CGFloat?, right: CGFloat?) {
    if let left = left {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
      self.leftView = paddingView
      self.leftViewMode = .always
    }
    if let right = right {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
      self.rightView = paddingView
      self.rightViewMode = .always
    }
  }
}
