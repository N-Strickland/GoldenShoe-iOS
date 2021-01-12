//
//  SortConfigViewController.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 08/01/2021.
//

import UIKit

enum SortTypes {
  case priceLowToHigh
  case priceHighToLow
  case nameAToZ
  case nameZToA
}

protocol SortConfigViewControllerDelegate: class {
  func sortConfig(_ sortConfig: SortConfigViewController, sortFilterSelected: SortTypes?)
  func sortConfigClearFilters(_ sortConfig: SortConfigViewController)
}

final class SortConfigViewController: UIViewController {
  // MARK: - View Outlets
  private lazy var rootView = RefineBarMenuView(
    height: UIScreen.main.bounds.height * 0.45,
    title: "SORT",
    showFilterButton: false,
    isScrollable: false)
  private unowned var tableView: UITableView { return rootView.tableView }
  private unowned var closeButton: UIButton { return rootView.closeButton }
  private unowned var clearButton: UIButton { return rootView.clearButton }

  // MARK: - Instance Properties
  weak var delegate: SortConfigViewControllerDelegate?

  var currentSort: SortTypes?

  private var lastSelected: SortOptionTableViewCell?

  // MARK: - Lifecycle Methods
  override func loadView() {
    view = rootView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(SortOptionTableViewCell.self, forCellReuseIdentifier: "sortCell")
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.rowHeight = UITableView.automaticDimension
    closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
    clearButton.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
  }

  // MARK: - Actions
  @objc private func closeButtonPressed() {
    dismiss(animated: true, completion: nil)
  }

  @objc private func clearButtonPressed() {
    delegate?.sortConfigClearFilters(self)
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - SortConfigViewController + UITableViewDelegate + UITableViewDataSource
extension SortConfigViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let selectedCell = tableView.cellForRow(at: indexPath) as?
            SortOptionTableViewCell else { return }
    selectedCell.isChosen.toggle()

    for index in 0..<4 {
      guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as?
              SortOptionTableViewCell else { return }
      if cell.isChosen && cell !== selectedCell {
        cell.isChosen = false
      }
    }

    switch indexPath.row {
    case 0: delegate?.sortConfig(self, sortFilterSelected: selectedCell.isChosen ? .priceLowToHigh : nil)
    case 1: delegate?.sortConfig(self, sortFilterSelected: selectedCell.isChosen ? .priceHighToLow: nil)
    case 2: delegate?.sortConfig(self, sortFilterSelected: selectedCell.isChosen ? .nameAToZ: nil)
    case 3: delegate?.sortConfig(self, sortFilterSelected: selectedCell.isChosen ? .nameZToA: nil)
    default: fatalError("Sort config not implemented")
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.dismiss(animated: true, completion: nil)
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = SortOptionTableViewCell(style: .default, reuseIdentifier: "sortCell")
    switch indexPath.row {
    case 0:
      cell.myTextLabel.text = "Price Low to High"
      if let currentSort = currentSort, currentSort == .priceLowToHigh {
        cell.isChosen = true
      } else {
        cell.isChosen = false
      }
    case 1:
      cell.myTextLabel.text = "Price High to Low"
      if let currentSort = currentSort, currentSort == .priceHighToLow {
        cell.isChosen = true
      } else {
        cell.isChosen = false
      }
    case 2:
      cell.myTextLabel.text = "Name (A-Z)"
      if let currentSort = currentSort, currentSort == .nameAToZ {
        cell.isChosen = true
      } else {
        cell.isChosen = false
      }
    case 3:
      cell.myTextLabel.text = "Name (Z-A)"
      if let currentSort = currentSort, currentSort == .nameZToA {
        cell.isChosen = true
      } else {
        cell.isChosen = false
      }
    default: fatalError("Undefined cell type")
    }
    return cell
  }
}
