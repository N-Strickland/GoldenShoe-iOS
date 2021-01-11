//
//  FilterConfigViewController.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 09/01/2021.
//

import UIKit

protocol FilterConfigViewControllerDelegate: class {
  func filterConfigClose(
    _: FilterConfigViewController,
    withFiltersApplied filters: [FilterTypes: [String]]
  )
  func filterConfigClearFilters(_: FilterConfigViewController)
}

final class FilterConfigViewController: UIViewController {
  // MARK: - View Outlets
  private lazy var rootView = RefineBarMenuView(
    height: UIScreen.main.bounds.height * 0.90,
    title: "FILTER",
    showFilterButton: true,
    isScrollable: false)
  private unowned var tableView: UITableView { return rootView.tableView }
  private unowned var closeButton: UIButton { return rootView.closeButton }
  private unowned var clearButton: UIButton { return rootView.clearButton }
  private unowned var viewItemsButton: UIButton { return rootView.filterButton }

  // MARK: - Instance Properties
  var selectedFilters: [FilterTypes: [String]] = [
    FilterTypes.sale: [],
    FilterTypes.brand: [],
    FilterTypes.color: [],
    FilterTypes.price: []
  ]

  weak var delegate: FilterConfigViewControllerDelegate?

  private let productData = Products.shared

  // MARK: - Lifecycle Methods
  override func loadView() {
    view = rootView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(FilterSelectionTableViewCell.self, forCellReuseIdentifier: "filterCell")
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.rowHeight = UITableView.automaticDimension
    navigationController?.isNavigationBarHidden = true
    closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
    viewItemsButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
    clearButton.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
  }

  // MARK: - Helper Methods
  private func updateLabels(_ type: FilterTypes) {
    switch type {
    case .brand: tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
    case .sale: tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    case .color: tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
    case .price: tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .automatic)
    }
  }

  // MARK: - Actions
  @objc private func closeButtonPressed() {
    delegate?.filterConfigClose(self, withFiltersApplied: selectedFilters)
    dismiss(animated: true, completion: nil)
  }

  @objc private func clearButtonPressed() {
    selectedFilters = [
      FilterTypes.sale: [],
      FilterTypes.brand: [],
      FilterTypes.color: [],
      FilterTypes.price: []
    ]
    tableView.reloadData()
    delegate?.filterConfigClearFilters(self)
  }
}

// MARK: - FilterConfigViewController + UITableViewDataSource + UITableViewDelegate
extension FilterConfigViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = FilterSelectionTableViewCell(style: .default, reuseIdentifier: "filterCell")
    switch indexPath.row {
    case 0:
      cell.filterLabel.text = "Sale"
      let filters = selectedFilters[.sale]!
      cell.detailLabel.text = filters.isEmpty ? "All" : filters.joined(separator: ", ")
    case 1:
      cell.filterLabel.text = "Brand"
      let filters = selectedFilters[.brand]!
      cell.detailLabel.text = filters.isEmpty ? "All" : filters.joined(separator: ", ")
    case 2:
      cell.filterLabel.text = "Color"
      let filters = selectedFilters[.color]!
      cell.detailLabel.text = filters.isEmpty ? "All" : filters.joined(separator: ", ")
    case 3:
      cell.filterLabel.text = "Price"
      let filters = selectedFilters[.price]!
      cell.detailLabel.text = filters.isEmpty ? """
        £\(String(format: "%.0f", productData.minProductPrice)) to \
        £\(String(format: "%.0f", productData.maxProductPrice))
        """
        : "\(filters[0]) to \(filters[1])"
    default: fatalError("Undefined cell type")
    }
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
      let filterVC = FilterSelectionViewController(type: .sale)
      filterVC.delegate = self
      filterVC.selectedFilters = selectedFilters[.sale] ?? []
      navigationController?.pushViewController(filterVC, animated: true)
    case 1:
      let filterVC = FilterSelectionViewController(type: .brand)
      filterVC.delegate = self
      filterVC.selectedFilters = selectedFilters[.brand] ?? []
      navigationController?.pushViewController(filterVC, animated: true)
    case 2:
      let filterVC = FilterSelectionViewController(type: .color)
      filterVC.delegate = self
      filterVC.selectedFilters = selectedFilters[.color] ?? []
      navigationController?.pushViewController(filterVC, animated: true)
    case 3:
      let filterVC = FilterSelectionViewController(type: .price)
      filterVC.delegate = self
      filterVC.selectedFilters = selectedFilters[.price] ?? []
      navigationController?.pushViewController(filterVC, animated: true)
    default: fatalError("Undefined filter config")
  }
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

// MARK: - FilterConfigViewController + FilterSelectionViewControllerDelegate
extension FilterConfigViewController: FilterSelectionViewControllerDelegate {
  func filterSelectionBackPressed(
    _: FilterSelectionViewController,
    withFilters: [String],
    forType: FilterTypes) {
    selectedFilters[forType] = withFilters
    updateLabels(forType)
  }

  func filterSelectionViewItemsPressed(
    _: FilterSelectionViewController,
    withFilters: [String],
    forType: FilterTypes) {
    selectedFilters[forType] = withFilters
    updateLabels(forType)
    dismiss(animated: true, completion: nil)
    delegate?.filterConfigClose(self, withFiltersApplied: selectedFilters)
  }
}
