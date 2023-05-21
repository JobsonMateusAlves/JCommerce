//
//  TotalPurchaseView.swift
//  
//
//  Created by Jobson Mateus on 21/05/23.
//

import UIKit

class TotalPurchaseView: UIView {

    private let totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .primaryText
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "Total"
        return label
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .primaryText
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continuar a compra", for: .normal)
        button.setTitleColor(.terciaryText, for: .normal)
        button.backgroundColor = UIColor.primaryColor
        button.layer.cornerRadius = 8
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        setupShadow()
    }
    
    func bind(totalProductsPrice: String) {
        totalPriceLabel.text = totalProductsPrice
    }
    
    // MARK: setup
    func setupShadow() {
        layer.shadowColor = UIColor.shadow.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 8
    }
}

// MARK: Layout
extension TotalPurchaseView {
    func setupLayout() {
        setupGeneralStackViewLayout()
        setupContinueButtonLayout()
        backgroundColor = .white
    }
    
    func setupGeneralStackViewLayout() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(totalLabel)
        stackView.addArrangedSubview(totalPriceLabel)

        let constraints: [NSLayoutConstraint] = [
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 32)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func setupContinueButtonLayout() {
        addSubview(continueButton)
        
        let constraints: [NSLayoutConstraint] = [
            continueButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            continueButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 44),
            continueButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
