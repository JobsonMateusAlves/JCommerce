//
//  ProductCollectionViewCell.swift
//  
//
//  Created by Jobson Mateus on 19/05/23.
//

import UIKit
import Domain

class ProductCollectionViewCell: UICollectionViewCell {
    let productImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let basketImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "shopping-bag")
        imageView.tintColor = UIColor(hex: "B4B3B2")
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let promotionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let imageLoader: ImageLoader = ImageLoader()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        isUserInteractionEnabled = true
    }
    
    func bind(product: Product) {
        nameLabel.text = product.name.capitalized
        priceLabel.text = product.regularPrice
        productImageView.image = UIImage(named: "placeholder")
        if let url = URL(string: product.image) {
            imageLoader.loadImage(with: url) { [weak self] image in
                self?.productImageView.image = image
            }
        }
    }
}

// MARK: Layout
extension ProductCollectionViewCell {
    func setupLayout() {
        setupCellLayout()
        setupProductImageViewLayout()
        setupNameLabelLayout()
        setupBasketImageViewLayout()
        setupPriceLabelLayout()
        setupPromotionLabelLayout()
    }
    
    func setupCellLayout() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.cornerRadius = 8
        backgroundColor = .white
    }
    
    func setupProductImageViewLayout() {
        addSubview(productImageView)
        
        let constraints: [NSLayoutConstraint] = [
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            productImageView.heightAnchor.constraint(equalToConstant: 90)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupNameLabelLayout() {
        addSubview(nameLabel)
        
        let constraints: [NSLayoutConstraint] = [
            nameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupBasketImageViewLayout() {
        addSubview(basketImageView)
        
        let constraints: [NSLayoutConstraint] = [
            basketImageView.topAnchor.constraint(greaterThanOrEqualTo: nameLabel.bottomAnchor, constant: 4),
            basketImageView.heightAnchor.constraint(equalToConstant: 24),
            basketImageView.widthAnchor.constraint(equalToConstant: 24),
            basketImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            basketImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupPriceLabelLayout() {
        addSubview(priceLabel)
        
        let constraints: [NSLayoutConstraint] = [
            priceLabel.centerYAnchor.constraint(equalTo: basketImageView.centerYAnchor),
            priceLabel.trailingAnchor.constraint(greaterThanOrEqualTo: basketImageView.leadingAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupPromotionLabelLayout() {
        addSubview(promotionLabel)
        
        let constraints: [NSLayoutConstraint] = [
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
