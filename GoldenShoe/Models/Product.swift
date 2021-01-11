//
//  Product.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 06/01/2021.
//

import Foundation

class Product {
  var favourited: Bool
  var productID: Int
  var filters: [String: String]
  var shortDescription: String
  var longDescription: String
  var brand: String
  var color: String
  var price: String
  var onSale: Bool
  var salePrice: String?
  var imagesURL: [String]

  init(
    favourited: Bool,
    productID: Int,
    filters: [String: String],
    shortDescription: String,
    longDescription: String,
    brand: String,
    color: String,
    price: String,
    onSale: Bool,
    salePrice: String?,
    imagesURL: [String]
  ) {
    self.favourited = favourited
    self.productID = productID
    self.filters = filters
    self.shortDescription = shortDescription
    self.longDescription = longDescription
    self.brand = brand
    self.color = color
    self.price = price
    self.onSale = onSale
    self.salePrice = salePrice
    self.imagesURL = imagesURL
  }
}
