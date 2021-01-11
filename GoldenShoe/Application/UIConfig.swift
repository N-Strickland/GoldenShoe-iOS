//
//  UIConfig.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 01/01/2021.
//

import UIKit

struct UIStyle {
  struct Fonts {
    static let titleFont = UIFont(name: "Lato-Bold", size: 34)
    static let primaryFont = UIFont(name: "Roboto-Regular", size: 17)
    static let secondaryFont = UIFont(name: "Roboto-Regular", size: 15)
    static let tertiaryFont = UIFont(name: "Roboto-Light", size: 13)
    static let controlFont = UIFont(name: "Roboto-Medium", size: 19)
    static let smallFont = UIFont(name: "Roboto-Medium", size: 10)
  }

  struct Colors {
    static let mainBackgroundColor = UIColor.systemBackground
    static let secondaryBackgroundColor = UIColor.secondarySystemBackground
    static let mainTextColor = UIColor.label
    static let titleTextColor =  UIColor.label
    static let elementFill = UIColor(red: 138/255, green: 11/255, blue: 28/255, alpha: 1)
    static let buttonBorder = UIColor.systemGray
    static let buttonFill = UIColor.clear
    static let textFieldFill = UIColor.clear
    static let textFieldColor = UIColor.label
    static let backButtonFill = UIColor.systemGray
  }

  struct Icons {
    static let backArrowIcon = UIImage(named: "arrow-back-icon")!
    static let shoppingBasket = UIImage(named: "ShoppingBasket")!
  }
}
