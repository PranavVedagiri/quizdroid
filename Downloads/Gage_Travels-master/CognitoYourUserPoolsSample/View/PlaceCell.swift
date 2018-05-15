//
//  PlaceCell.swift
//  Gage
//
//  Created by Zac on 12/22/17.
//  Copyright © 2017 Zac. All rights reserved.
//

import UIKit

/// PlaceCell class
class PlaceCell: Cell
{
    /// thumbnailImageView for place image view display
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        // Default set to Seattle, override in HomeController
        // Rending for changing color when selecting
        imageView.image = UIImage(named: "Seattle")?.withRenderingMode(.alwaysOriginal)
        // Keep correct ratio and not out of bounds
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor(red: 90, green: 10, blue: 10)
        return imageView
    }()

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupCell()
    }

    override func setupCell()
    {
        addSubview(thumbnailImageView)
        // thumbnailImageView constrain
        // Herizentol constrain from 10 pixels from left boundry and 10 pixels from right boudry
        addConstrainWithFormat(format: "H:|-10-[v0]-10-|", views: thumbnailImageView)
        // Vertical constrain from 10 pixels from top boundry and 10 pixels from bottom boudry
        addConstrainWithFormat(format: "V:|-10-[v0]-10-|", views: thumbnailImageView)
    }

    override var isHighlighted: Bool {
        didSet
        {
            print("yes")
//            thumbnailImageView.tintColor = isHighlighted ? UIColor.rgbWtihAlphaOne(red: 90, green: 10, blue: 10) : .white
        }
    }

    override var isSelected: Bool
    {
        didSet
        {
            print(123)
//            thumbnailImageView.tintColor = isSelected ? UIColor.rgbWtihAlphaOne(red: 90, green: 10, blue: 10) : .white
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

