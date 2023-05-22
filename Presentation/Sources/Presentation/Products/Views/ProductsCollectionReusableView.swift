//
//  ProductsHeaderCollectionReusableView.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import UIKit

protocol ProductsHeaderCollectionReusableViewDelegate: AnyObject {
    func onChangeOnSaleFilterLabel(value: Bool)
}

class ProductsHeaderCollectionReusableView: UICollectionReusableView {
    
    let numberOfProductsLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .primaryText
        return label
    }()
    
    let onSaleStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    let onSaleFilterLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .primaryText
        label.text = "On sale"
        return label
    }()
    
    let onSaleFilterSwitch: UISwitch = {
        let view: UISwitch = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.onTintColor = .primaryColor
        return view
    }()
    
    weak var delegate: ProductsHeaderCollectionReusableViewDelegate?
    
    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupSwitch()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        setupSwitch()
    }
    
    func bind(numberOfProducts: Int) {
        numberOfProductsLabel.text = "\(numberOfProducts) Products"
    }
    
    func setupSwitch() {
        onSaleFilterSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }
    
    @objc func switchValueChanged() {
        delegate?.onChangeOnSaleFilterLabel(value: onSaleFilterSwitch.isOn)
    }
}

// MARK: Layout
extension ProductsHeaderCollectionReusableView {
    func setupLayout() {
        setupNumberOfProductsLabelLayout()
        setupOnSaleSwitchLayout()
        backgroundColor = .primaryBackgroundColor
    }
    
    func setupNumberOfProductsLabelLayout() {
        addSubview(numberOfProductsLabel)
        
        let constraints: [NSLayoutConstraint] = [
            numberOfProductsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            numberOfProductsLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    func setupOnSaleSwitchLayout() {
        addSubview(onSaleStackView)
        
        onSaleStackView.addArrangedSubview(onSaleFilterLabel)
        onSaleStackView.addArrangedSubview(onSaleFilterSwitch)
        
        let constraints: [NSLayoutConstraint] = [
            onSaleStackView.leadingAnchor.constraint(greaterThanOrEqualTo: numberOfProductsLabel.trailingAnchor, constant: 8),
            onSaleStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            onSaleStackView.topAnchor.constraint(equalTo: topAnchor),
            onSaleStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
