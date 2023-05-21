//
//  ShoppingCartViewController.swift
//  
//
//  Created by Jobson Mateus on 21/05/23.
//

import UIKit

public protocol ShoppingCart {}

public class ShoppingCartViewController: UIViewController {
    
    // MARK: Properties
    private let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .primaryBackgroundColor
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let viewModel: ShoppingCartViewModel
    private let coordinator: (Coordinator & ShoppingCart)
    
    public init(viewModel: ShoppingCartViewModel, coordinator: (Coordinator & ShoppingCart)) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupLayout()
        setupTableView()
        loadData()
    }
    
    func loadData() {
        viewModel.fetchProductItems { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: Setup
    func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.navigationBar.layoutIfNeeded()
        }
        navigationItem.rightBarButtonItem?.tintColor = .primaryColor
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductItemTableViewCell.self, forCellReuseIdentifier: "ProductItemTableViewCell")
    }
}

// MARK: - UITableViewDelegate And UITableViewDataSource
extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfProductItems
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductItemTableViewCell", for: indexPath) as? ProductItemTableViewCell else {
            return UITableViewCell()
        }
        cell.bind(productItem: viewModel.productItemAt(index: indexPath.row))
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        (viewModel.productItemAt(index: indexPath.row).product?.onSale ?? true) ? 160 : 140
    }
}

// MARK: - Layout
extension ShoppingCartViewController {

    func setupLayout() {
        setupTableViewLayout()
    }

    func setupTableViewLayout() {
        view.addSubview(tableView)

        let constraints: [NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
