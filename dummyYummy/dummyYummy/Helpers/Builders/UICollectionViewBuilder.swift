//
//  CollectionViewBuilder.swift
//  dummyYummy
//
//  Created by badyi on 12.06.2021.
//

import UIKit

final class UICollectionViewBuilder {
    public private(set) var translatesAutoresizingMaskIntoConstraints: Bool = false
    public private(set) var backgroundColor: UIColor = .black
    public private(set) var delegate: UICollectionViewDelegate? = nil
    public private(set) var dataSource: UICollectionViewDataSource? = nil
    public private(set) var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    public private(set) var alwaysBounceVertical: Bool = true
    public private(set) var insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    public private(set) var showsVerticalScrollIndicator: Bool = false
}

extension UICollectionViewBuilder {
    @discardableResult
    public func showsVerticalScrollIndicator(_ flag: Bool) -> UICollectionViewBuilder {
        self.showsVerticalScrollIndicator = flag
        return self
    }
    
    @discardableResult
    public func setInsets(_ insets: UIEdgeInsets) -> UICollectionViewBuilder {
        self.insets = insets
        return self
    }
    
    @discardableResult
    public func alwaysBounceVertical (_ flag: Bool) -> UICollectionViewBuilder {
        self.alwaysBounceVertical = flag
        return self
    }
    
    @discardableResult
    public func layout(_ layout: UICollectionViewFlowLayout) -> UICollectionViewBuilder {
        self.layout = layout
        return self
    }
    
    @discardableResult
    public func dataSource(_ dataSource: UICollectionViewDataSource?) -> UICollectionViewBuilder {
        self.dataSource = dataSource
        return self
    }
    
    @discardableResult
    public func delegate(_ delegate: UICollectionViewDelegate) -> UICollectionViewBuilder {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    public func translatesAutoresizingMaskIntoConstraints(_ flag: Bool) -> UICollectionViewBuilder {
        translatesAutoresizingMaskIntoConstraints = flag
        return self
    }

    @discardableResult
    public func backgroundColor(_ color: UIColor) -> UICollectionViewBuilder {
        backgroundColor = color
        return self
    }

    public func build() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        collectionView.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        collectionView.backgroundColor = backgroundColor
        collectionView.alwaysBounceVertical = alwaysBounceVertical
        collectionView.contentInset = insets
        
        if delegate != nil {
            collectionView.delegate = delegate
        }
        if dataSource != nil {
            collectionView.dataSource = dataSource
        }

        return collectionView
    }
}
