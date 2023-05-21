//
//  ProductsViewController.swift
//
//
//  Created by Jobson Mateus on 19/05/23.
//

import UIKit
import Domain

public protocol Products {
    func startShoppingCartFlow()
    func startProductDetailFlow(product: Product)
}

public class ProductsViewController: UIViewController {
    
    // MARK: Properties
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .primaryBackgroundColor
        return collectionView
    }()
    
    private let viewModel: ProductsViewModel
    private let coordinator: (Coordinator & Products)
    
    // MARK: Inits
    public init(viewModel: ProductsViewModel, coordinator: (Coordinator & Products)) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupCollectionView()
        loadData()
        
        title = "JCommerce"
        setupNavigation()
    }
    
    func loadData() {
        viewModel.fetchProducts { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    // MARK: Setup
    func setupNavigation() {
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.primaryColor]
        navigationController?.navigationBar.tintColor = UIColor.primaryColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage.shoppingCartIcon,
            style: .plain,
            target: self,
            action: #selector(openShoppingCart)
        )
        navigationItem.rightBarButtonItem?.tintColor = .primaryColor
        navigationItem.backButtonTitle = ""
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCollectionViewCell")
        collectionView.register(ProductsHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProductsHeaderCollectionReusableView")
    }
    
    @objc func openShoppingCart() {
        coordinator.startShoppingCartFlow()
    }
}

// MARK: - UICollectionViewDelegate And UICollectionViewDataSource
extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfProducts
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.bind(product: viewModel.productAt(index: indexPath.item))
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator.startProductDetailFlow(product: viewModel.productAt(index: indexPath.item))
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (view.frame.width/2) - 24, height: 208)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        24
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProductsHeaderCollectionReusableView", for: indexPath) as! ProductsHeaderCollectionReusableView

            headerView.bind(numberOfProducts: viewModel.numberOfProducts)
            return headerView
        }

        return UICollectionReusableView()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 32)
    }
}

// MARK: Layout
extension ProductsViewController {
    func setupLayout() {
        setupCollectionViewLayout()
        view.backgroundColor = .primaryBackgroundColor
    }
    
    func setupCollectionViewLayout() {
        view.addSubview(collectionView)

        let constraints: [NSLayoutConstraint] = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
