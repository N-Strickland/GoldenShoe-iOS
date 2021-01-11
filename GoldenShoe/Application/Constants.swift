//
//  Constants.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 01/01/2021.
//

import UIKit

struct Assets {
  struct Images {
    static let companyLogo = "CompanyLogo"
  }

  struct Fonts {
    static let regularSmallFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    static let regularMediumFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    static let regularLargeFont = UIFont.systemFont(ofSize: 18, weight: .regular)
    static let boldSmallFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
    static let boldMediumFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
    static let boldLargeFont = UIFont.systemFont(ofSize: 26, weight: .semibold)
  }

  struct Color {
    static let mainTextColor = UIColor(named: "MainTextColor")
    static let titleTextColor = UIColor(named: "TitleTextColor")
  }
}
