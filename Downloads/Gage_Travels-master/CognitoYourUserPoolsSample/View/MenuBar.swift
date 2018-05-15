//
//  MenuBar.swift
//  Gage
//
//  Created by Zac on 12/22/17.
//  Copyright © 2017 Zac. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        view.backgroundColor = UIColor.rgbWtihAlphaOne(red: 200, green: 200, blue: 200)
        view.backgroundColor = .black
        view.dataSource = self
        view.delegate = self
        return view
    }()

    let menuBarItemId = "menuBarItemId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: menuBarItemId)
        addSubview(collectionView)
        addConstrainWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstrainWithFormat(format: "V:|[v0]|", views: collectionView)
    }
    
    /// Setup cell number, only 1 for search bar
    ///
    /// - Parameters:
    ///   - collectionView:
    ///   - section:
    /// - Returns:
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    /// Setup cell
    ///
    /// - Parameters:
    ///   - collectionView:
    ///   - indexPath:
    /// - Returns:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuBarItemId, for: indexPath) as! MenuCell

        // Add search bar to MenuCell
        
        
        
        
        return cell
    }
    
    /// Determine cell size
    ///
    /// - Parameters:
    ///   - collectionView:
    ///   - collectionViewLayout:
    ///   - indexPath:
    /// - Returns:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Only 1 cell
        return CGSize(width: frame.width, height: frame.height)
    }
    
    /// Setup space between cells
    ///
    /// - Parameters:
    ///   - collectionView:
    ///   - collectionViewLayout:
    ///   - section:
    /// - Returns:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
