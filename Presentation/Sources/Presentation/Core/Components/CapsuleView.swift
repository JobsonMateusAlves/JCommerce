//
//  DiscountPercentageView.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import UIKit

class CapsuleView: UIView {

    let numberOfProductsLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
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
}
