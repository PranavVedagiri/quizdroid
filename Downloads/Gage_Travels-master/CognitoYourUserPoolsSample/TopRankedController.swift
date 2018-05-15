//
//  TopRankedController.swift
//  Gage
//
//  Created by Zac on 2/18/18.
//  Copyright © 2018 Zac. All rights reserved.
//

import UIKit

class TopRankedController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    
    var places = [Place]()
    
    let cellId = "cellId"
    
    let headId = "headId"
    
    let footerId = "footerId"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        setupPlaces()
        
        collectionView?.backgroundColor = .white
        
        collectionView?.register(TopRankedCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headId)
        
        collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerId)
    }
    
    private func setupPlaces()
    {
        // Fake data, fetch from backend later
        let fileNames = ["Seattle", "Tacoma", "Portland"]
        let placeNames = ["Seattle, WA", "Tacoma, WA", "Portland, OR"]
        let arrivedDates = ["June 1 2018", "June 1 2017", "June 1 2016"]
        let leftDates = ["June 3 2018", "June 4 2017", "June 5 2016"]
        
        for (index, _) in placeNames.enumerated()
        {
            let place = Place(placeName: placeNames[index],
                              fileName: fileNames[index],
                              arrivedDateString: arrivedDates[index],
                              leftDateString: leftDates[index])
            
            places.append(place)
        }
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return places.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TopRankedCell
        let place = places[indexPath.item]
//        let placeCell = PlaceCell()
        
        // Catch nil pointer exceptions
        guard let imagePropertyName = place.fileName else { return cell }
//        let placeImage = UIImage(named: imagePropertyName)
//        placeCell.thumbnailImageView.image = placeImage
        
        cell.wordLabel.text = place.placeName
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.width, height: view.frame.height / 10)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
//    {
//        return 0
//    }
    
    // Header
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        // Header
        
        if kind == UICollectionElementKindSectionHeader
        {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headId, for: indexPath)
            
            header.backgroundColor = .blue
            
            
            
            
            return header
            
        }
            
        // Footer
            
        else
        {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
            
            footer.backgroundColor = .purple
            
            
            
            
            return footer
        }
    }
    
    // Header
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        return CGSize(width: view.frame.width, height: view.frame.height / 10)
    }
    
    // Footer
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
    {
        return CGSize(width: view.frame.width, height: view.frame.height / 5)
    }
    
}
