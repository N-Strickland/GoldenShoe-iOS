//
//  HomeScreenViewController.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 02/01/2021.
//

// swiftlint:disable file_length

import UIKit
import ScrollableSegmentedControl

final class HomeScreenViewController: UIViewController {
  // MARK: - View Outlets
  private lazy var rootView = HomeScreenView()
  private unowned var collectionView: UICollectionView { return rootView.collectionView }
  private unowned var filterSelection: ScrollableSegmentedControl { return rootView.filterSelection }
  private unowned var refineBar: UIStackView { return rootView.refineBar }
  private unowned var sortButton: UIButton { return rootView.sortButton }
  private unowned var filterButton: UIButton { return rootView.filterButton }

  // MARK: - Instance Properties
  private let filterState = FilterState()
  private var lastContentOffset: CGFloat = 0
  private var isScrollbyDrag = false
  private var productData = Products.shared

  private var selectedFilterIndex: Int? = nil {
    didSet {
      if let selectedFilterIndex = selectedFilterIndex, selectedFilterIndex > -1 {
        if !filterState.isHomeNode && selectedFilterIndex == 0 {
          goUpFilterLevel()
        } else {
          goDownFilterLevel()
        }
      }
    }
  }

  private var currentSort: SortTypes? {
    didSet {
      if currentSort != nil {
        sortButton.setTitle("SORT ∙", for: .normal)
      } else {
        sortButton.setTitle("SORT", for: .normal)
      }
    }
  }

  private var currentFilters: [FilterTypes: [String]]? {
    didSet {
      guard let filters = currentFilters else { return }
      filterButton.setTitle("FILTER ∙", for: .normal)
      if filters[.brand]!.isEmpty && filters[.color]!.isEmpty && filters[.price]!.isEmpty && filters[.sale]!.isEmpty {
        filterButton.setTitle("FILTER", for: .normal)
      }
    }
  }

  // MARK: - Lifecycle Methods
  override func loadView() {
    view = rootView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavBar()
    configureRefineBar()
    configureCollectionView()
    configureFilterSegments()
  }

  // MARK: - Helper Methods
  private func configureNavBar() {
    let basketBarItem = UIBarButtonItem(
      image: UIImage(systemName: "cart"),
      style: .plain,
      target: self,
      action: #selector(checkoutBasketPressed))

    navigationItem.rightBarButtonItem = basketBarItem
    navigationItem.rightBarButtonItem?.tintColor = .black

    let titleButton = UIButton(type: .custom)
    titleButton.setTitle(filterState.selectedFilter.capitalized, for: .normal)
    titleButton.addTarget(self, action: #selector(returnToTop), for: .touchUpInside)
    titleButton.setTitleColor(.black, for: .normal)
    titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    titleButton.translatesAutoresizingMaskIntoConstraints = false

    titleButton.contentHorizontalAlignment = .center
    titleButton.titleLabel?.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    navigationItem.titleView = titleButton

    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .systemBackground
    appearance.shadowColor = .clear

    navigationItem.standardAppearance = appearance
    navigationItem.scrollEdgeAppearance = appearance
    navigationItem.compactAppearance = appearance

    configureSearchBar()
  }

  private func configureRefineBar() {
    sortButton.addTarget(self, action: #selector(sortButtonPressed), for: .touchUpInside)
    filterButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
  }

  private func configureSearchBar() {
    let search = UISearchController(searchResultsController: nil)
    search.obscuresBackgroundDuringPresentation = false
    search.searchBar.placeholder = "Begin search..."
    search.searchBar.delegate = self
    navigationItem.searchController = search
    navigationItem.hidesSearchBarWhenScrolling = false
  }

  private func configureCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(
      StandardStoreItemCollectionViewCell.self,
      forCellWithReuseIdentifier: "standardCell")
    collectionView.register(
      OnSaleStoreItemCollectionViewCell.self,
      forCellWithReuseIdentifier: "saleCell")
    collectionView.register(
      UICollectionFooterView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
      withReuseIdentifier: "footerView")
  }

  private func configureFilterSegments() {
    filterSelection.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    updateFilterLabels()
  }

  private func goDownFilterLevel() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
      guard let selectedFilterIndex = self.selectedFilterIndex else { return }
      self.filterState.setCurrentFilterToChild(at: selectedFilterIndex)
      if !self.filterState.isCurrentNodeLeaf {
        self.filterSelection.removeAllSegments()
    } else {
      self.filterState.setCurrentFilterToSibling(at: selectedFilterIndex)
    }
      self.updateFilterLabels()
      self.filterProductData()
      self.updateCollectionView()
      self.removeSearchTerm()
      self.rootView.isSmall = false
    }
  }

  private func goUpFilterLevel() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
      guard self.selectedFilterIndex != nil else { return }
      self.filterSelection.removeAllSegments()
      self.filterState.setCurrentFilterToParent()
      self.rootView.isSmall = self.filterState.isHomeNode
      self.updateFilterLabels()
      self.filterProductData()
      self.updateCollectionView()
      self.removeSearchTerm()
    }
  }

  private func updateFilterLabels() {
    guard let titleButton = navigationItem.titleView as? UIButton else { return }
    titleButton.setTitle(filterState.selectedFilter.capitalized, for: .normal)
    let visibleFilterNodes = filterState.visibleSubFilters

    for (index, node) in visibleFilterNodes.enumerated() {
      if node.value == "back" {
        filterSelection.insertSegment(withTitle: "╳", at: index)
      } else {
        filterSelection.insertSegment(withTitle: node.value.capitalized, at: index)
      }
    }
    selectedFilterIndex = nil
  }

  private func filterProductData() {
    let appliedFilters = filterState.appliedFilters
    print(appliedFilters)
    switch filterState.appliedFilters.count {
    case 0: productData.filterBy(criteria: nil)
    case 1: productData.filterBy(criteria: ["category": appliedFilters[0]])
    case 2: productData.filterBy(criteria: ["category": appliedFilters[1], "type": appliedFilters[0]])
    case 3: productData.filterBy(criteria: [
      "category": appliedFilters[2],
      "type": appliedFilters[1],
      "style": appliedFilters[0]
    ])
    default: fatalError("Undefined filter config")
    }
    if let currentFilters = currentFilters {
      productData.filterBy(currentFilters)
    }
    if let currentSort = currentSort {
      productData.sortBy(sortType: currentSort)
    }
  }

  private func updateCollectionView() {
    collectionView.isHidden = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
      guard let self = self else { return }
      self.collectionView.reloadData()
      self.returnToTop()
      if self.collectionView.numberOfItems(inSection: 0) == 0 {
        self.collectionView.backgroundView = NoItemsFoundView()
      } else {
        self.collectionView.backgroundView = nil
      }
      self.collectionView.isHidden = false
    }
  }

  private func removeSearchTerm() {
    navigationItem.searchController?.isActive = false
  }

  // MARK: - Actions
  @objc private func checkoutBasketPressed() {
    let alertVC = UIAlertController(
      title: "Oh no!",
      message: "Basket and checkout functionality has not been implemented for this demonstration!",
      preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alertVC, animated: true, completion: nil)
  }

  @objc private func segmentChanged() {
    if selectedFilterIndex == nil {
      selectedFilterIndex = filterSelection.selectedSegmentIndex
    }
    filterSelection.isUserInteractionEnabled = false
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.filterSelection.isUserInteractionEnabled = true
    }
  }

  @objc private func returnToTop() {
    let topOffset = CGPoint(x: -collectionView.contentInset.left, y: -collectionView.contentInset.top)
    collectionView.setContentOffset(topOffset, animated: true)
  }

  @objc private func sortButtonPressed() {
    let sortVC = SortConfigViewController()
    sortVC.modalPresentationStyle = .formSheet
    sortVC.delegate = self
    sortVC.currentSort = currentSort
    present(sortVC, animated: true, completion: nil)
  }

  @objc private func filterButtonPressed() {
    let filterVC = FilterConfigViewController()
    let filterNav = UINavigationController(rootViewController: filterVC)
    filterVC.delegate = self
    if let currentFilters = currentFilters {
      filterVC.selectedFilters = currentFilters
    }
    filterVC.modalPresentationStyle = .formSheet
    filterNav.modalPresentationStyle = .formSheet
    present(filterNav, animated: true, completion: nil)
  }

  @objc private func saveButtonPressed(sender: UIButton) {
    guard let cell = collectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0))
            as? StandardStoreItemCollectionViewCell else { return }
    cell.isFavourited.toggle()
    productData.filteredProducts[sender.tag].favourited.toggle()
  }
}

// MARK: - HomeScreenViewController + UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HomeScreenViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let viewWidth = collectionView.frame.width - (collectionView.contentInset.left * 2)
    return CGSize(width: viewWidth / 2.04, height: viewWidth / 1.5)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return productData.filteredProducts.count
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let product = productData.filteredProducts[indexPath.row]

    if product.onSale, let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "saleCell",
        for: indexPath)
        as? OnSaleStoreItemCollectionViewCell {
      if let url = URL(string: product.imagesURL.first!) {
        cell.imageView.load(url: url)
      } else {
        cell.imageView.backgroundColor = .gray
      }
      cell.brandLabel.text = product.brand
      cell.shortDescriptionLabel.text = product.shortDescription
      cell.saveButton.tag = indexPath.row
      cell.isFavourited = product.favourited
      cell.saveButton.addTarget(self, action: #selector(saveButtonPressed(sender:)), for: .touchUpInside)
      cell.salePriceLabel.text = product.salePrice
      let string = NSMutableAttributedString(string: product.price)
      // swiftlint:disable legacy_constructor
      string.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, string.length))
      cell.priceLabel.attributedText = string
      return cell
    }

    if !product.onSale, let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "standardCell",
        for: indexPath)
        as? StandardStoreItemCollectionViewCell {
      if let url = URL(string: product.imagesURL.first!) {
        cell.imageView.load(url: url)
      } else {
        cell.imageView.backgroundColor = .gray
      }
      cell.brandLabel.text = product.brand
      cell.shortDescriptionLabel.text = product.shortDescription
      cell.priceLabel.text = product.price
      cell.saveButton.tag = indexPath.row
      cell.isFavourited = product.favourited
      cell.saveButton.addTarget(self, action: #selector(saveButtonPressed(sender:)), for: .touchUpInside)
      return cell
    }
    return UICollectionViewCell()
  }

  func collectionView(
    _ collectionView: UICollectionView,
    viewForSupplementaryElementOfKind kind: String,
    at indexPath: IndexPath
  ) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionFooter {
      guard let footerView = collectionView.dequeueReusableSupplementaryView(
              ofKind: kind,
              withReuseIdentifier: "footerView",
              for: indexPath) as? UICollectionFooterView else { return UICollectionReusableView() }
      footerView.returnToTopButton.addTarget(
        self,
        action: #selector(returnToTop),
        for: .touchUpInside)
      if collectionView.contentOffset.y < 0 {
        footerView.isHidden = true
      } else {
        footerView.isHidden = false
      }
      return footerView
    } else {
      return UICollectionReusableView()
    }
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    referenceSizeForFooterInSection section: Int
  ) -> CGSize {
    return CGSize(width: 100, height: 60)
  }
}

// MARK: - HomeScreenViewController + UIScrollViewDelegate
extension HomeScreenViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard isScrollbyDrag else { return }
    guard abs(lastContentOffset - scrollView.contentOffset.y) > 50  else { return }
    if lastContentOffset > scrollView.contentOffset.y {
      filterSelection.isHidden = false
    } else if lastContentOffset < scrollView.contentOffset.y {
      filterSelection.isHidden = true
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

// MARK: - HomeScreenViewController + UISearchBarDelegate
extension HomeScreenViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    productData.filterBy(searchTerm: searchText)
    updateCollectionView()
  }

  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    guard let titleButton = navigationItem.titleView as? UIButton else { return }
    if let searchBarText = searchBar.text, !searchBarText.isEmpty {
      titleButton.setTitle("'\(searchBarText)' in \(filterState.selectedFilter.capitalized)", for: .normal)
    }
    navigationItem.searchController?.isActive = false
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    productData.filterBy(searchTerm: "")
    updateCollectionView()
  }
}

// MARK: - HomeScreenViewController + SortConfigViewControllerDelegate
extension HomeScreenViewController: SortConfigViewControllerDelegate {
  func sortConfig(_ sortConfig: SortConfigViewController, sortFilterSelected: SortTypes?) {
    guard let sortType = sortFilterSelected else {
      currentSort = nil
      productData.sortBy(sortType: nil)
      updateCollectionView()
      return
    }
    switch sortType {
    case .nameAToZ:
      productData.sortBy(sortType: .nameAToZ)
      currentSort = .nameAToZ
    case .nameZToA:
      productData.sortBy(sortType: .nameZToA)
      currentSort = .nameZToA
    case .priceHighToLow:
      productData.sortBy(sortType: .priceHighToLow)
      currentSort = .priceHighToLow
    case .priceLowToHigh:
      productData.sortBy(sortType: .priceLowToHigh)
      currentSort = .priceLowToHigh
    }
    updateCollectionView()
  }

  func sortConfigClearFilters(_ sortConfig: SortConfigViewController) {
    productData.sortBy(sortType: nil)
    currentSort = nil
    updateCollectionView()
  }
}

extension HomeScreenViewController: FilterConfigViewControllerDelegate {
  func filterConfigClose(_: FilterConfigViewController, withFiltersApplied filters: [FilterTypes: [String]]) {
    currentFilters = filters
    productData.filterBy(filters)
    removeSearchTerm()
    updateCollectionView()
  }

  func filterConfigClearFilters(_: FilterConfigViewController) {
    currentFilters = [
      FilterTypes.sale: [],
      FilterTypes.brand: [],
      FilterTypes.color: [],
      FilterTypes.price: []
    ]
    productData.filterBy(currentFilters!)
    filterProductData()
    removeSearchTerm()
    updateCollectionView()
  }
}

extension HomeScreenViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let alertVC = UIAlertController(
      title: "Oh no!",
      message: "Product description and checkout has not been implemented for this demonstration",
      preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alertVC, animated: true, completion: nil)
  }
}
