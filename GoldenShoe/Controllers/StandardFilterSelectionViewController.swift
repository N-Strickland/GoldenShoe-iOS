//
//  FilterSelectionViewController.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 09/01/2021.
//

import UIKit

final class StandardFilterSelectionViewController: UIViewController {
  // MARK: - View Outlets
  private lazy var rootView = StandardFilterSelectView(height: 750, title: filterTitle!, showFilterButton: false)
  // MARK: - Instance Properties
  var filterTitle: String?

  // MARK: - Lifecycle Methods
  init(filterTitle: String) {
    self.filterTitle = filterTitle
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    view = rootView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
