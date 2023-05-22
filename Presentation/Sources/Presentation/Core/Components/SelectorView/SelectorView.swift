//
//  SelectorView.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import UIKit

struct SelectorItem {
    var title: String
    var selected: Bool
}

protocol SelectorViewDelegate: AnyObject {
    func onSelect(item: SelectorItem)
}

class SelectorView: UIView {
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var items: [SelectorItem] = []
    weak var delegate: SelectorViewDelegate?
    
    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        setupCollectionView()
    }
    
    func bind(items: [SelectorItem]) {
        self.items = items
        collectionView.reloadData()
    }

    // MARK: Setup
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemSelectorCollectionViewCell.self, forCellWithReuseIdentifier: "ItemSelectorCollectionViewCell")
    }
}

// MARK: - UICollectionViewDelegate And UICollectionViewDataSource
extension SelectorView: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemSelectorCollectionViewCell", for: indexPath) as? ItemSelectorCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.bind(item: items[indexPath.item])
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onSelect(item: items[indexPath.item])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SelectorView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.height, height: frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// MARK: Layout
extension SelectorView {
    func setupLayout() {
        setupCollectionViewLayout()
    }
    
    func setupCollectionViewLayout() {
        addSubview(collectionView)

        let constraints: [NSLayoutConstraint] = [
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
