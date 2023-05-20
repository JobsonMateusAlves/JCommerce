//
//  DiscountPercentageView.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import UIKit

class CapsuleView: UIView {

    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .primaryText
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    var text: String = "" {
        didSet {
            textLabel.text = text
        }
    }
    
    var font: UIFont = .systemFont(ofSize: 12, weight: .medium) {
        didSet {
            textLabel.font = font
        }
    }
    
    var textColor: UIColor = .primaryText {
        didSet {
            textLabel.textColor = textColor
        }
    }
    
    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension CapsuleView {
    func setupLayout() {
        setupTextLabelLayout()
        
        layoutIfNeeded()
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.border.cgColor
    }
    
    func setupTextLabelLayout() {
        addSubview(textLabel)
        
        let constraints: [NSLayoutConstraint]  = [
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
