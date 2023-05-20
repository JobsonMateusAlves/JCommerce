//
//  ProductDetailViewController.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import UIKit
import Domain

public protocol ProductDetail {
    var product: Product? { get set }
}

public class ProductDetailViewController: UIViewController {
    
    let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryText
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let sellerLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryText
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = "por JCommerce"
        return label
    }()
    
    let productImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .secondaryBackgroundColor
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.border.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    let colorLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    let sizeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryText
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    let sizeSelectorView: SelectorView = {
        let selectorView: SelectorView = SelectorView()
        selectorView.translatesAutoresizingMaskIntoConstraints = false
        return selectorView
    }()
    
    private let imageLoader: ImageLoader = ImageLoader()
    private let viewModel: ProductDetailViewModel
    private let coordinator: (Coordinator & ProductDetail)
    
    public init(viewModel: ProductDetailViewModel, coordinator: (Coordinator & ProductDetail)) {
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
        setupSelectorView()
        setupLayout()
        loadData()
        
        viewModel.onChange { [weak self] in
            self?.loadData()
        }
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.navigationBar.layoutIfNeeded()
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage.shareIcon,
            style: .plain,
            target: self,
            action: #selector(share)
        )
        navigationItem.rightBarButtonItem?.tintColor = .primaryTintColor
    }
    
    func setupSelectorView() {
        sizeSelectorView.delegate = self
    }
    
    func loadData() {
        productImageView.setPlaceholder(image: UIImage.placeholderImage)
        if let url = URL(string: viewModel.product.image) {
            imageLoader.loadImage(with: url) { [weak self] image in
                self?.productImageView.setImage(image: image)
            }
        }
        
        nameLabel.text = viewModel.product.name.capitalized
        setColorLabel()
        setSizeLabel()
        sizeSelectorView.bind(items: viewModel.availableSizes.map({ SelectorItem(title: $0.size, selected: viewModel.selectedSize?.size == $0.size) }))
    }
    
    func setColorLabel() {
        let attributedText = NSMutableAttributedString(string: "Cor: ")
        let fontAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .bold)
        ]
        attributedText.append(NSAttributedString(string: "\(viewModel.product.color.capitalized)", attributes: fontAttribute))
        colorLabel.attributedText = attributedText
    }
    
    func setSizeLabel() {
        let attributedText = NSMutableAttributedString(string: "Tamanho: ")
        let fontAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .bold)
        ]
        if let size = viewModel.selectedSize {
            attributedText.append(NSAttributedString(string: "\(size.size)", attributes: fontAttribute))
        } else {
            attributedText.append(NSAttributedString(string: "Escolha uma opção", attributes: fontAttribute))
        }
        sizeLabel.attributedText = attributedText
    }
    
    @objc func share() {
        
    }
}

extension ProductDetailViewController: SelectorViewDelegate {
    func onSelect(item: SelectorItem) {
        viewModel.select(by: item.title)
    }
}

// MARK: Layout
extension ProductDetailViewController {
    func setupLayout() {
        setupNameLabelLayout()
        setupSellerLabelLayout()
        setupCollectionViewLayout()
        setupColorLabelLayout()
        setupSizeLabelLayout()
        setupSizeSelectorViewLayout()
        view.backgroundColor = .secondaryBackgroundColor
    }
    
    func setupNameLabelLayout() {
        view.addSubview(nameLabel)
        
        let constraints: [NSLayoutConstraint] = [
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupSellerLabelLayout() {
        view.addSubview(sellerLabel)
        
        let constraints: [NSLayoutConstraint] = [
            sellerLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            sellerLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            sellerLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupCollectionViewLayout() {
        view.addSubview(productImageView)

        let constraints: [NSLayoutConstraint] = [
            productImageView.topAnchor.constraint(equalTo: sellerLabel.bottomAnchor, constant: 8),
            productImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 240)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func setupColorLabelLayout() {
        view.addSubview(colorLabel)
        
        let constraints: [NSLayoutConstraint] = [
            colorLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            colorLabel.leadingAnchor.constraint(equalTo: sellerLabel.leadingAnchor),
            colorLabel.trailingAnchor.constraint(equalTo: sellerLabel.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupSizeLabelLayout() {
        view.addSubview(sizeLabel)
        
        let constraints: [NSLayoutConstraint] = [
            sizeLabel.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 8),
            sizeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            sizeLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupSizeSelectorViewLayout() {
        view.addSubview(sizeSelectorView)
        
        let constraints: [NSLayoutConstraint] = [
            sizeSelectorView.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 8),
            sizeSelectorView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            sizeSelectorView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            sizeSelectorView.heightAnchor.constraint(equalToConstant: 44)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
