//
//  ProductsHeaderCollectionReusableView.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import UIKit

class ProductsHeaderCollectionReusableView: UICollectionReusableView {
    
    let numberOfProductsLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .primaryText
        return label
    }()
    
    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func bind(numberOfProducts: Int) {
        numberOfProductsLabel.text = "\(numberOfProducts) Products"
    }
}

// MARK: Layout
extension ProductsHeaderCollectionReusableView {
    func setupLayout() {
        setupNumberOfProductsLabelLayout()
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
}
