//
//  SelectorItemCollectionViewCell.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import UIKit

class ItemSelectorCollectionViewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryText
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
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
        isUserInteractionEnabled = true
    }
    
    func bind(item: SelectorItem) {
        titleLabel.text = item.title
        layer.borderColor = item.selected ? UIColor.saleCapsuleBackgroundColor.cgColor : UIColor.border.cgColor
    }
}

extension ItemSelectorCollectionViewCell {
    func setupLayout() {
        setupCellLayout()
        setupTitleLabelLayout()
    }
    
    func setupCellLayout() {
        layer.cornerRadius = 4
        layer.borderWidth = 2
    }
    
    func setupTitleLabelLayout() {
        addSubview(titleLabel)
        
        let constraints: [NSLayoutConstraint] = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
