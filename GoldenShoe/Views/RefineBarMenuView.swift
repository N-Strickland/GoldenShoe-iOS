//
//  SortConfigView.swift
//  GoldenShoe
//
//  Created by Nathan Strickland on 08/01/2021.
//

import UIKit

class RefineBarMenuView: UIView {
  // MARK: - RefineBarMenuView Subviews
  private lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray6
    view.layer.cornerRadius = 20
    return view
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    label.textColor = .black
    label.text = menuTitle
    return label
  }()

  private lazy var seperatorLine: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray3
    return view
  }()

  public lazy var closeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "xmark"), for: .normal)
    button.tintColor = .black
    return button
  }()

  public lazy var clearButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("CLEAR", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    button.setTitleColor(.gray, for: .normal)
    return button
  }()

  public lazy var tableView: DynamicTableView = {
    let tableView = DynamicTableView()
    tableView.backgroundColor = .white
    return tableView
  }()

  public lazy var filterButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("View Items", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = UIColor(red: 47/255, green: 51/255, blue: 48/255, alpha: 1)
    button.layer.cornerRadius = 5
    button.layer.masksToBounds = false
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOffset = CGSize(width: 0, height: 0)
    button.layer.shadowRadius = 1
    button.layer.shadowOpacity = 0.5
    return button
  }()

  // MARK: - Instance Properties
  var viewHeight: CGFloat?
  var menuTitle: String?
  var showFilterButton: Bool?
  var isScrollable: Bool?

  // MARK: - Lifecycle Methods
  init(height: CGFloat, title: String, showFilterButton: Bool, isScrollable: Bool) {
    super.init(frame: .zero)
    viewHeight = height
    menuTitle = title
    self.showFilterButton = showFilterButton
    self.isScrollable = isScrollable
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Helper Methods
  private func setupView() {
    tableView.isScrollEnabled = isScrollable ?? true
    backgroundColor = .clear
    setupViewsForAutoLayout(views: [containerView, closeButton, titleLabel, clearButton, seperatorLine, tableView])
    if let showFilterButton = showFilterButton, showFilterButton {
      setupViewForAutoLayout(view: filterButton)
    }
    configureConstraints()
  }

  private func configureConstraints() {
    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      containerView.heightAnchor.constraint(equalToConstant: viewHeight ?? 500),

      closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
      closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
      closeButton.heightAnchor.constraint(equalToConstant: 50),
      closeButton.widthAnchor.constraint(equalToConstant: 50),

      titleLabel.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

      clearButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -5),
      clearButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),

      seperatorLine.heightAnchor.constraint(equalToConstant: 1),
      seperatorLine.trailingAnchor.constraint(equalTo: trailingAnchor),
      seperatorLine.leadingAnchor.constraint(equalTo: leadingAnchor),
      seperatorLine.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 2)
    ])

    if let showFilterButton = showFilterButton, showFilterButton {
      NSLayoutConstraint.activate([
        filterButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -5),
        filterButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
        filterButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
        filterButton.heightAnchor.constraint(equalToConstant: 40)
      ])
    }

    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.topAnchor.constraint(equalTo: seperatorLine.bottomAnchor),
      tableView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
    ])
  }
}
