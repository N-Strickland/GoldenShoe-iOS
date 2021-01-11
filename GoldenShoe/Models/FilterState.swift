//
//  FilterState.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 04/01/2021.
//

import Foundation

final class FilterState {
  // MARK: - Instance Properties
  private let homeNode = TreeNode<String>(value: "all products")
  private var currentNode: TreeNode<String>

  public var selectedFilter: String { currentNode.value }
  public var visibleSubFilters: [TreeNode<String>] { currentNode.children }
  public var isHomeNode: Bool { currentNode === homeNode }
  public var isCurrentNodeLeaf: Bool { currentNode.children.isEmpty }

  public var filterLevel: Int {
    var level = 0
    var tempNode = currentNode
    while tempNode.parent != nil {
      level += 1
      tempNode = tempNode.parent!
    }
    return level
  }

  public var appliedFilters: [String] {
    var filters: [String] = []
    var tempNode = currentNode
    while tempNode.parent != nil {
      filters.append(tempNode.value)
      tempNode = tempNode.parent!
    }
    return filters
  }

  // MARK: - Lifecycle Methods
  init() {
    currentNode = homeNode
    buildTree()
  }

  // MARK: - Helper Methods
  func setCurrentFilterToChild(at index: Int) {
    guard index >= 0  && index < currentNode.children.count else { return }
    currentNode = currentNode.children[index]
  }

  func setCurrentFilterToParent() {
    currentNode = currentNode.parent ?? homeNode
  }

  func setCurrentFilterToSibling(at index: Int) {
    currentNode = currentNode.parent!.children[index]
  }

  func setCurrentFilterToHome() {
    currentNode = homeNode
  }

  // swiftlint:disable function_body_length
  // Currently hard-coded, later will convert filter format from backend
  private func buildTree() {
//    homeNode.addChild(TreeNode(value: "sale"))
    homeNode.addChild(TreeNode(value: "womens"))
    homeNode.addChild(TreeNode(value: "mens"))
    homeNode.addChild(TreeNode(value: "kids"))
    homeNode.addChild(TreeNode(value: "accessories"))

//    // Sale
//    homeNode.children[0].addChild(TreeNode(value: "back"))
//    homeNode.children[0].addChild(TreeNode(value: "womens"))
//    homeNode.children[0].addChild(TreeNode(value: "mens"))
//    homeNode.children[0].addChild(TreeNode(value: "kids"))

    // Womens
    homeNode.children[0].addChild(TreeNode(value: "back"))
    homeNode.children[0].addChild(TreeNode(value: "boots"))
    homeNode.children[0].addChild(TreeNode(value: "heels"))
    homeNode.children[0].addChild(TreeNode(value: "sandals"))
    homeNode.children[0].addChild(TreeNode(value: "slippers"))
    homeNode.children[0].addChild(TreeNode(value: "trainers"))

    // Womens -> Boots
    homeNode.children[0].children[1].addChild(TreeNode(value: "back"))
    homeNode.children[0].children[1].addChild(TreeNode(value: "alternative"))
    homeNode.children[0].children[1].addChild(TreeNode(value: "biker"))
    homeNode.children[0].children[1].addChild(TreeNode(value: "casual ankle"))
    homeNode.children[0].children[1].addChild(TreeNode(value: "casual calf"))
    homeNode.children[0].children[1].addChild(TreeNode(value: "casual knee"))
    homeNode.children[0].children[1].addChild(TreeNode(value: "outdoor"))

    // Womens -> Heels
    homeNode.children[0].children[2].addChild(TreeNode(value: "back"))
    homeNode.children[0].children[2].addChild(TreeNode(value: "casual courts"))
    homeNode.children[0].children[2].addChild(TreeNode(value: "party shoes"))
    homeNode.children[0].children[2].addChild(TreeNode(value: "sling back"))
    homeNode.children[0].children[2].addChild(TreeNode(value: "stilettos"))
    homeNode.children[0].children[2].addChild(TreeNode(value: "strappy"))

    // Womens -> Sanda0s
    homeNode.children[0].children[3].addChild(TreeNode(value: "back"))
    homeNode.children[0].children[3].addChild(TreeNode(value: "flip flops"))
    homeNode.children[0].children[3].addChild(TreeNode(value: "footbeds"))
    homeNode.children[0].children[3].addChild(TreeNode(value: "mules"))
    homeNode.children[0].children[3].addChild(TreeNode(value: "sandals"))
    homeNode.children[0].children[3].addChild(TreeNode(value: "sports"))

    // Womens -> Train0rs
    homeNode.children[0].children[5].addChild(TreeNode(value: "back"))
    homeNode.children[0].children[5].addChild(TreeNode(value: "alternative"))
    homeNode.children[0].children[5].addChild(TreeNode(value: "core classic"))
    homeNode.children[0].children[5].addChild(TreeNode(value: "fashion sports"))
    homeNode.children[0].children[5].addChild(TreeNode(value: "fitness"))
    homeNode.children[0].children[5].addChild(TreeNode(value: "hi tops"))
    homeNode.children[0].children[5].addChild(TreeNode(value: "skate"))

    // Mens
    homeNode.children[1].addChild(TreeNode(value: "back"))
    homeNode.children[1].addChild(TreeNode(value: "boots"))
    homeNode.children[1].addChild(TreeNode(value: "sandals"))
    homeNode.children[1].addChild(TreeNode(value: "shoes"))
    homeNode.children[1].addChild(TreeNode(value: "slippers"))
    homeNode.children[1].addChild(TreeNode(value: "trainers"))

    // Kids
    homeNode.children[2].addChild(TreeNode(value: "back"))
    homeNode.children[2].addChild(TreeNode(value: "shoes"))
    homeNode.children[2].addChild(TreeNode(value: "school"))
    homeNode.children[2].addChild(TreeNode(value: "sandals"))
    homeNode.children[2].addChild(TreeNode(value: "trainers"))

    // Accessories
    homeNode.children[3].addChild(TreeNode(value: "back"))
    homeNode.children[3].addChild(TreeNode(value: "Shoe Cleaning"))
    homeNode.children[3].addChild(TreeNode(value: "Wallets"))
    homeNode.children[3].addChild(TreeNode(value: "Travel"))
  }
}
