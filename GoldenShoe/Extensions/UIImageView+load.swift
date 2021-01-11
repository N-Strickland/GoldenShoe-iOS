//
//  UIImageView+load.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 06/01/2021.
//

import UIKit

extension UIImageView {
  func load(url: URL) {
    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self.image = image
          }
        }
      }
    }
  }
}
