//
//  TreeNode.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 04/01/2021.
//

import Foundation

public class TreeNode<T> {
  public var value: T
  public weak var parent: TreeNode?
  public var children = [TreeNode<T>]()

  public init(value: T) {
    self.value = value
  }

  public func addChild(_ node: TreeNode<T>) {
    children.append(node)
    node.parent = self
  }
}
