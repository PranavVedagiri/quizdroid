//
//  TopRankedCell.swift
//  Gage
//
//  Created by Zac on 2/18/18.
//  Copyright © 2018 Zac. All rights reserved.
//

import UIKit

class TopRankedCell: Cell
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    var wordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sweet"
        return label
    }()
    
    override func setupCell() {
        super.setupCell()
     
        backgroundColor = .gray

        let firstView = UIView()
        firstView.translatesAutoresizingMaskIntoConstraints = false
        
        let placeImageView: UIImageView = {
            let iv = UIImageView()
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.image = UIImage(named: "Seattle")
            iv.contentMode = .scaleAspectFill
            return iv
        }()

        
        
        
        setupImageCell(view: firstView, imageView: placeImageView)
        
        
        let secondView = UIView()
        secondView.backgroundColor = .green
        secondView.translatesAutoresizingMaskIntoConstraints = false
        
        let thirdView = UIView()
        thirdView.backgroundColor = .black
        thirdView.translatesAutoresizingMaskIntoConstraints = false
        
        let addToTripButton: UIButton = {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Add To Trip", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
            
            
            button.addTarget(self, action: #selector(addToTrip), for: .touchUpInside)
            return button
        }()
        
        setupTripCell(view: thirdView, button: addToTripButton)
       
        
        let stackView = UIStackView(arrangedSubviews: [firstView, secondView, thirdView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        

        firstView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1/5).isActive = true
        secondView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 3/5).isActive = true
        thirdView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1/5).isActive = true
        
        stackView.distribution = .fillProportionally
    }
    
    private func setupImageCell(view: UIView, imageView: UIImageView)
    {
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    
    private func setupTripCell(view: UIView, button: UIButton)
    {
        view.addSubview(button)
        button.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    @objc private func addToTrip()
    {
        print("Sweet")
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
