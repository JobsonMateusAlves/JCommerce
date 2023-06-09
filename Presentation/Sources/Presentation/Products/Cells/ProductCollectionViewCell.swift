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
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.borderColor = UIColor.border.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    let basketImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.shoppingBagIcon
        imageView.tintColor = .primaryColor
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryText
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let priceStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    let regularPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryText
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    let actualPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryText
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let saleCapsuleView: CapsuleView = {
        let capsuleView: CapsuleView = CapsuleView(frame: .zero)
        capsuleView.translatesAutoresizingMaskIntoConstraints = false
        capsuleView.textColor = .terciaryText
        capsuleView.backgroundColor = .primaryColor
        capsuleView.font = .systemFont(ofSize: 12, weight: .bold)
        return capsuleView
    }()
    
    private let imageLoader: ImageLoader = ImageLoader()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoader.cancel()
    }
    
    func bind(product: Product) {
        productImageView.setPlaceholder(image: UIImage.placeholderImage)
        if let url = URL(string: product.image) {
            imageLoader.loadImage(with: url) { [weak self] image in
                self?.productImageView.setImage(image: image)
            }
        }
        
        nameLabel.text = product.name.capitalized
        actualPriceLabel.text = product.actualPrice
        saleCapsuleView.text = "-\(product.discountPercentage)"
        setRegularPriceLabel(product: product)
        
        saleCapsuleView.isHidden = !product.onSale
        regularPriceLabel.isHidden = !product.onSale
    }
    
    func setRegularPriceLabel(product: Product) {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: product.regularPrice)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributeString.length))
        regularPriceLabel.attributedText = attributeString
    }
}

// MARK: Layout
extension ProductCollectionViewCell {
    func setupLayout() {
        setupCellLayout()
        setupProductImageViewLayout()
        setupNameLabelLayout()
        setupBasketImageViewLayout()
        setupPriceStackViewLayout()
        setupPromotionViewLayout()
    }
    
    func setupCellLayout() {
        layer.shadowColor = UIColor.shadow.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.cornerRadius = 8
        backgroundColor = .secondaryBackgroundColor
    }
    
    func setupProductImageViewLayout() {
        addSubview(productImageView)
        
        let constraints: [NSLayoutConstraint] = [
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
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
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupPriceStackViewLayout() {
        addSubview(priceStackView)
        
        priceStackView.addArrangedSubview(regularPriceLabel)
        priceStackView.addArrangedSubview(actualPriceLabel)
        
        let constraints: [NSLayoutConstraint] = [
            priceStackView.topAnchor.constraint(greaterThanOrEqualTo: nameLabel.bottomAnchor, constant: 8),
            priceStackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceStackView.trailingAnchor.constraint(lessThanOrEqualTo: basketImageView.leadingAnchor, constant: -8),
            priceStackView.centerYAnchor.constraint(equalTo: basketImageView.centerYAnchor),
            priceStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupPromotionViewLayout() {
        addSubview(saleCapsuleView)
        
        let constraints: [NSLayoutConstraint] = [
            saleCapsuleView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            saleCapsuleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            saleCapsuleView.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        saleCapsuleView.setupLayout()
    }
}
