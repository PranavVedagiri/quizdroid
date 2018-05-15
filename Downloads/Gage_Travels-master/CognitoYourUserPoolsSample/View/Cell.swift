//
//  Cell.swift
//  Gage
//
//  Created by Zac on 12/22/17.
//  Copyright © 2017 Zac. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    /// Setup the cell
    func setupCell()
    {
        // setup cell here
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
