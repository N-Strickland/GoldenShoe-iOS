//
//  FilterSelectionViewController.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 09/01/2021.
//

import UIKit
import RangeSeekSlider

enum FilterTypes: CaseIterable {
  case sale
  case brand
  case color
  case price
}

protocol FilterSelectionViewControllerDelegate: class {
  func filterSelectionBackPressed(_: FilterSelectionViewController, withFilters: [String], forType: FilterTypes)
  func filterSelectionViewItemsPressed(_: FilterSelectionViewController, withFilters: [String], forType: FilterTypes)
}

final class FilterSelectionViewController: UIViewController {
  // MARK: - View Outlets
  private lazy var rootView = RefineBarMenuView(
    height: UIScreen.main.bounds.height * 0.90,
    title: filterTitle,
    showFilterButton: true,
    isScrollable: filterType == .price ? false : true)
  private unowned var tableView: UITableView { return rootView.tableView }
  private unowned var backButton: UIButton { return rootView.closeButton }
  private unowned var clearButton: UIButton { return rootView.clearButton }
  private unowned var viewItemsButton: UIButton { return rootView.filterButton }

  // MARK: - Instance Properties
  weak var delegate: FilterSelectionViewControllerDelegate?

  private let productData = Products.shared
  private let filterType: FilterTypes
  private let filterTitle: String
  private var lastContentOffset: CGFloat = 0
  private var isScrollbyDrag = false

  var selectedFilters: [String] = []

  // MARK: - Lifecycle Methods
  init(type: FilterTypes) {
    filterType = type
    switch filterType {
    case .brand: filterTitle = "Brand"
    case .color: filterTitle = "Colour"
    case .sale: filterTitle = "Sale"
    case .price: filterTitle = "Price"
    }
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
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(StandardFilterSelectionCell.self, forCellReuseIdentifier: "standardFilterSelect")
    tableView.register(PriceFilterConfigCell.self, forCellReuseIdentifier: "priceFilterSelect")
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.rowHeight = UITableView.automaticDimension
    backButton.setImage(UIImage(systemName: "arrow.backward")!, for: .normal)
    backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    clearButton.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
    viewItemsButton.addTarget(self, action: #selector(viewItemsButtonPressed), for: .touchUpInside)
  }

  // MARK: - Actions
  @objc private func backButtonPressed() {
    delegate?.filterSelectionBackPressed(self, withFilters: selectedFilters, forType: filterType)
    navigationController?.popViewController(animated: true)
  }

  @objc private func viewItemsButtonPressed() {
    delegate?.filterSelectionViewItemsPressed(self, withFilters: selectedFilters, forType: filterType)
    navigationController?.popViewController(animated: true)
  }

  @objc private func clearButtonPressed() {
    selectedFilters = []
    tableView.reloadData()
  }
}

// MARK: - FilterSelectionViewController + UITableViewDelegate, UITableViewDataSource
extension FilterSelectionViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch filterType {
    case .brand: return productData.brandCounts.count
    case .color: return productData.colorCounts.count
    case .sale: return 2
    case .price: return 1
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if filterType != .price {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "standardFilterSelect", for: indexPath)
              as? StandardFilterSelectionCell else { return UITableViewCell() }
      switch filterType {
      case .brand:
        let brand = productData.brandCounts[indexPath.row]
        cell.itemLabel.text = brand.key
        cell.detailLabel.text = "(\(brand.value))"
        cell.isChecked = selectedFilters.contains(brand.key)
      case .color:
        let color = productData.colorCounts[indexPath.row]
        cell.itemLabel.text = color.key
        cell.detailLabel.text = "(\(color.value))"
        cell.isChecked = selectedFilters.contains(color.key)
      case .sale:
        let sale = productData.saleCounts
        if indexPath.row == 0 {
          cell.itemLabel.text = "On Sale"
          cell.detailLabel.text = "(\(sale["On Sale"]!))"
          cell.isChecked = selectedFilters.contains("On Sale")
        } else {
          cell.itemLabel.text = "Not On Sale"
          cell.detailLabel.text = "(\(sale["Not On Sale"]!))"
          cell.isChecked = selectedFilters.contains("Not On Sale")
        }
      case .price: print("price")
      }
      return cell
    } else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "priceFilterSelect", for: indexPath)
              as? PriceFilterConfigCell else { return UITableViewCell() }
      cell.priceRange.delegate = self
      cell.priceRange.minValue = CGFloat(productData.minProductPrice).rounded()
      cell.priceRange.selectedMinValue = CGFloat(productData.minProductPrice).rounded()
      cell.priceRange.maxValue = CGFloat(productData.maxProductPrice).rounded()
      cell.priceRange.selectedMaxValue = CGFloat(productData.maxProductPrice).rounded()

      return cell
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? StandardFilterSelectionCell else { return }
    cell.isChecked.toggle()
    if cell.isChecked {
      selectedFilters.append(cell.itemLabel.text!)
    } else {
      selectedFilters.removeAll { $0 == cell.itemLabel.text! }
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension FilterSelectionViewController: RangeSeekSliderDelegate {
  func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
    let string1 = "£" + String(format: "%.0f", Double(minValue))
    let string2 = "£" + String(format: "%.0f", Double(maxValue))
    if selectedFilters.count < 2 {
      selectedFilters.append(string1)
      selectedFilters.append(string2)
    } else {
      selectedFilters[0] = string1
      selectedFilters[1] = string2
    }
  }

  func didStartTouches(in slider: RangeSeekSlider) {
    navigationController?.presentationController?.presentedView?.gestureRecognizers?.forEach {
            $0.isEnabled = false
    }
  }

  func didEndTouches(in slider: RangeSeekSlider) {
    navigationController?.presentationController?.presentedView?.gestureRecognizers?.forEach {
            $0.isEnabled = true
    }
  }
}

extension FilterSelectionViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard isScrollbyDrag else { return }
    guard abs(lastContentOffset - scrollView.contentOffset.y) > 50  else { return }
    if lastContentOffset > scrollView.contentOffset.y {
      viewItemsButton.isHidden = false
    } else if lastContentOffset < scrollView.contentOffset.y {
      viewItemsButton.isHidden = true
    }
    lastContentOffset = scrollView.contentOffset.y
  }

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    isScrollbyDrag = true
  }

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    isScrollbyDrag = false
  }
}
