//
//  MenuItem.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 02/01/2021.
//

import UIKit

struct MenuItem {
  var title: String
  var image: UIImage
  var url: String
  var itemSize: MenuItemSize
}

enum MenuItemSize {
  case large
  case medium
  case small
  case wideLong
}
