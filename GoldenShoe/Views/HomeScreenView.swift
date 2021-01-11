//
//  HomeScreenView.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 02/01/2021.
//

import UIKit
import ScrollableSegmentedControl

final class HomeScreenView: UIView {
  // MARK: - HomeScreenView Subviews
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 14
    layout.minimumInteritemSpacing = 5

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -2)
    collectionView.bounces = true

    return collectionView
  }()

  lazy var filterSelection: ScrollableSegmentedControl = {
    let segmentControl = ScrollableSegmentedControl()
    segmentControl.segmentStyle = .textOnly

    segmentControl.backgroundColor = UIColor(white: 1, alpha: 0.90)
    segmentControl.underlineSelected = true
    segmentControl.fixedSegmentWidth = false

    segmentControl.setTitleTextAttributes([
                                            NSAttributedString.Key.foregroundColor: UIColor.black,
                                            NSAttributedString.Key.font: UIFont.systemFont(
                                              ofSize: 16, weight: .regular)
                                          ], for: .selected)
    segmentControl.setTitleTextAttributes([
                                            NSAttributedString.Key.foregroundColor: UIColor.systemGray,
                                            NSAttributedString.Key.font: UIFont.systemFont(
                                              ofSize: 16,
                                              weight: .regular)
                                          ], for: .normal)

    segmentControl.layer.cornerRadius = 15
    segmentControl.layer.masksToBounds = false
    segmentControl.layer.shadowColor = UIColor.black.cgColor
    segmentControl.layer.shadowOffset = CGSize(width: 0, height: 0)
    segmentControl.layer.shadowRadius = 1
    segmentControl.layer.shadowOpacity = 0.5

    return segmentControl
  }()

  lazy var sortButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("SORT", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    button.setTitleColor(.black, for: .normal)
    button.widthAnchor.constraint(equalToConstant: 100).isActive = true
    return button
  }()

  lazy var filterButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("FILTER", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    button.setTitleColor(.black, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.widthAnchor.constraint(equalToConstant: 100).isActive = true
    return button
  }()

  lazy var refineBar: UIStackView = {
    let horizontalStack = UIStackView(arrangedSubviews: [
                                        leftSeperator,
                                        sortButton,
                                        seperator,
                                        filterButton,
                                        rightSeperator])
    horizontalStack.axis = .horizontal
    horizontalStack.alignment = .fill
    horizontalStack.distribution = .equalCentering
    horizontalStack.spacing = 5
    horizontalStack.layer.borderWidth = 1
    horizontalStack.layer.borderColor = UIColor.systemGray4.cgColor
    return horizontalStack
  }()

  private lazy var seperator: UIView = {
    let seperator = UIView()
    seperator.backgroundColor = .systemGray4
    seperator.widthAnchor.constraint(equalToConstant: 2).isActive = true
    return seperator
  }()

  private lazy var leftSeperator: UIView = {
    let seperator = UIView()
    seperator.widthAnchor.constraint(equalToConstant: 15).isActive = true
    return seperator
  }()

  private lazy var rightSeperator: UIView = {
    let seperator = UIView()
    seperator.widthAnchor.constraint(equalToConstant: 15).isActive = true
    return seperator
  }()

  private lazy var activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    activityIndicator.startAnimating()
    return activityIndicator
  }()

  var isSmall = true {
    didSet {
      updateWidth()
    }
  }

  var widthConstraint: NSLayoutConstraint?
  // MARK: - Lifecycle Methods
  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Helper Methods
  private func setupViews() {
    backgroundColor = .systemBackground
    setupViewsForAutoLayout(views: [activityIndicator, collectionView, filterSelection, refineBar])
    configureConstraints()
  }

  private func configureConstraints() {
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: refineBar.bottomAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),

      filterSelection.heightAnchor.constraint(equalToConstant: 38),
      filterSelection.bottomAnchor.constraint(
        equalTo: layoutMarginsGuide.bottomAnchor,
        constant: -10),
      filterSelection.centerXAnchor.constraint(equalTo: centerXAnchor),
//      filterSelection.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100),

      refineBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      refineBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      refineBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      refineBar.heightAnchor.constraint(equalToConstant: 38),

      activityIndicator.topAnchor.constraint(equalTo: refineBar.bottomAnchor, constant: 15),
      activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])

    widthConstraint = filterSelection.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100)
    widthConstraint?.isActive = true
  }

  private func updateWidth() {
    widthConstraint?.constant = isSmall ? UIScreen.main.bounds.width - 100 : UIScreen.main.bounds.width - 58
  }
}
