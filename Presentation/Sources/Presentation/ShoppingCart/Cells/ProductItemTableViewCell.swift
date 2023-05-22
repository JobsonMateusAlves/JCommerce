//
//  ProductItemTableViewCell.swift
//  
//
//  Created by Jobson Mateus on 21/05/23.
//

import UIKit
import Domain

protocol ProductItemTableViewCellDelegate: AnyObject {
    func increaseAmount(productItem: ProductItem)
    func decreaseAmount(productItem: ProductItem)
    func remove(productItem: ProductItem)
}

class ProductItemTableViewCell: UITableViewCell {
    
    let productItemImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.borderColor = UIColor.border.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryText
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let itemInfoStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let colorLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    let sizeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    let removeButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .primaryColor
        return button
    }()
    
    let decreaseButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = .primaryColor
        button.contentHorizontalAlignment = .left
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let increaseButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .primaryColor
        button.contentHorizontalAlignment = .right
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let amountLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryText
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.layer.cornerRadius = 4
        label.layer.borderColor = UIColor.border.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    let saleStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    let priceStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    let discountLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryColor
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    let regularPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryText
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    let actualPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryText
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let imageLoader: ImageLoader = ImageLoader()
    private var productItem: ProductItem?
    weak var delegate: ProductItemTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupButtons()
        setupLayout()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoader.cancel()
    }
    
    func bind(productItem: ProductItem) {
        self.productItem = productItem
        
        productItemImageView.setPlaceholder(image: UIImage.placeholderImage)
        if let imageString = productItem.product?.image, let url = URL(string: imageString) {
            imageLoader.loadImage(with: url) { [weak self] image in
                self?.productItemImageView.setImage(image: image)
            }
        }
        
        nameLabel.text = productItem.product?.name.capitalized ?? "-"
        actualPriceLabel.text = productItem.product?.actualPrice ?? "-"
        amountLabel.text = "\(productItem.amount)"
        discountLabel.text = "-\(productItem.product?.discountPercentage ?? "")"
        
        setColorLabel(color: productItem.product?.color ?? "-")
        setRegularPriceLabel(price: productItem.product?.regularPrice ?? "")
        setSizeLabel(size: productItem.size?.size ?? "")
        
        saleStackView.isHidden = !(productItem.product?.onSale ?? true)
    }
    
    func setRegularPriceLabel(price: String) {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: price)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributeString.length))
        regularPriceLabel.attributedText = attributeString
    }
    
    func setColorLabel(color: String) {
        let attributedText = NSMutableAttributedString(string: "Cor: ")
        let fontAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .bold)
        ]
        attributedText.append(NSAttributedString(string: "\(color.capitalized)", attributes: fontAttribute))
        colorLabel.attributedText = attributedText
    }
    
    func setSizeLabel(size: String) {
        let attributedText = NSMutableAttributedString(string: "Tamanho: ")
        let fontAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .bold)
        ]
        attributedText.append(NSAttributedString(string: "\(size.capitalized)", attributes: fontAttribute))
        sizeLabel.attributedText = attributedText
    }
    
    func setupButtons() {
        increaseButton.addTarget(self, action: #selector(increaseAmount), for: .touchUpInside)
        decreaseButton.addTarget(self, action: #selector(decreaseAmount), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(remove), for: .touchUpInside)
    }
    
    @objc func increaseAmount() {
        guard let productItem = self.productItem else { return }
        delegate?.increaseAmount(productItem: productItem)
    }
    
    @objc func decreaseAmount() {
        guard let productItem = self.productItem else { return }
        delegate?.decreaseAmount(productItem: productItem)
    }
    
    @objc func remove() {
        guard let productItem = self.productItem else { return }
        delegate?.remove(productItem: productItem)
    }
}

// MARK: Layout
extension ProductItemTableViewCell {
    func setupLayout() {
        setupProductImageViewLayout()
        setupNameLabelLayout()
        setupItemInfoStackViewLayout()
        setupRemoveButtonLayout()
        setupDecreaseButtonLayout()
        setupAmountLabelLayout()
        setupIncreaseButtonLayout()
        setupPriceStackViewLayout()
        
        backgroundColor = .clear
    }
    
    func setupProductImageViewLayout() {
        contentView.addSubview(productItemImageView)
        
        let constraints: [NSLayoutConstraint] = [
            productItemImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            productItemImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            productItemImageView.widthAnchor.constraint(equalToConstant: 48),
            productItemImageView.heightAnchor.constraint(equalToConstant: 48)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupNameLabelLayout() {
        contentView.addSubview(nameLabel)
        
        let constraints: [NSLayoutConstraint] = [
            nameLabel.topAnchor.constraint(equalTo: productItemImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: productItemImageView.trailingAnchor, constant: 8),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupItemInfoStackViewLayout() {
        contentView.addSubview(itemInfoStackView)
        
        itemInfoStackView.addArrangedSubview(colorLabel)
        itemInfoStackView.addArrangedSubview(sizeLabel)
        
        let constraints: [NSLayoutConstraint] = [
            itemInfoStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            itemInfoStackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            itemInfoStackView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupRemoveButtonLayout() {
        contentView.addSubview(removeButton)
        
        let constraints: [NSLayoutConstraint] = [
            removeButton.centerYAnchor.constraint(equalTo: productItemImageView.centerYAnchor),
            removeButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            removeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            removeButton.widthAnchor.constraint(equalToConstant: 32),
            removeButton.heightAnchor.constraint(equalToConstant: 32)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupDecreaseButtonLayout() {
        contentView.addSubview(decreaseButton)
        
        let constraints: [NSLayoutConstraint] = [
            decreaseButton.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            decreaseButton.widthAnchor.constraint(equalToConstant: 32),
            decreaseButton.heightAnchor.constraint(equalToConstant: 32)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupAmountLabelLayout() {
        contentView.addSubview(amountLabel)
        
        let constraints: [NSLayoutConstraint] = [
            amountLabel.topAnchor.constraint(equalTo: productItemImageView.bottomAnchor, constant: 16),
            amountLabel.centerYAnchor.constraint(equalTo: decreaseButton.centerYAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: decreaseButton.trailingAnchor, constant: 4),
            amountLabel.widthAnchor.constraint(equalToConstant: 32),
            amountLabel.heightAnchor.constraint(equalToConstant: 32),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupIncreaseButtonLayout() {
        contentView.addSubview(increaseButton)
        
        let constraints: [NSLayoutConstraint] = [
            increaseButton.centerYAnchor.constraint(equalTo: amountLabel.centerYAnchor),
            increaseButton.leadingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 4),
            increaseButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            increaseButton.widthAnchor.constraint(equalToConstant: 32),
            increaseButton.heightAnchor.constraint(equalToConstant: 32)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupPriceStackViewLayout() {
        contentView.addSubview(priceStackView)
        
        saleStackView.addArrangedSubview(discountLabel)
        saleStackView.addArrangedSubview(regularPriceLabel)
        priceStackView.addArrangedSubview(saleStackView)
        priceStackView.addArrangedSubview(actualPriceLabel)
        
        
        let constraints: [NSLayoutConstraint] = [
            priceStackView.centerYAnchor.constraint(equalTo: decreaseButton.centerYAnchor),
            priceStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            priceStackView.leadingAnchor.constraint(greaterThanOrEqualTo: increaseButton.trailingAnchor, constant: 8),
            priceStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
