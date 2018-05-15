//
//  Extensions.swift
//  Gage
//
//  Created by Zac on 12/22/17.
//  Copyright © 2017 Zac. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

// MARK: - for UIColor
extension UIColor
{
    // Add init overload, set default alpha to 1 and only int RGB number without / 255
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat)
    {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}

// MARK: - for layout constraint
extension UIView
{
    /// Constration helper function
    ///
    /// - Parameters:
    ///   - format:
    ///   - views: 
    func addConstrainWithFormat(format: String, views: UIView...)
    {
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated()
        {
            let key = "v\(index)"
            // Update new constrains
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

// MARK: - String and Date transformation
extension NSObject
{
    /// Transfer String to Date
    ///
    /// - Parameters:
    ///   - dateString:
    /// - Returns:
    func stringToDate(dateString: String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd yyyy"
        guard let date = dateFormatter.date(from: dateString) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        //        print(date)
        return date
    }
    
    /// Transfer Date to String in Month-Day-Year (June-01-2018)
    ///
    /// - Parameter date:
    /// - Returns:
    func dateToString(date: Date) -> String
    {
        let currentDateTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM-dd-yyyy"
        let stringDate:String = dateFormatter.string(from: currentDateTime)
        print(stringDate)
        return stringDate
    }
    
    /// Setup text on UIImage
    ///
    /// - Parameters:
    ///   - text: Text on image
    ///   - image: UIImage name
    ///   - point: CGPoint where text starts
    ///   - fontName: font name
    ///   - fontSize: font size
    /// - Returns: UIImage
    func textToImage(text: String, image: UIImage, point: CGPoint, fontName: String, fontSize: CGFloat) -> UIImage
    {
        let textColor = UIColor.white
        let textFont = UIFont(name: fontName, size: fontSize)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedStringKey.font: textFont,
            NSAttributedStringKey.foregroundColor: textColor,
            ] as [NSAttributedStringKey : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

// MARK: - Mainly for AccountController
extension UIViewController
{
    /// Helper func to setup UILabel
    ///
    /// - Parameter labelName:
    /// - Returns:
    func setupLabel(labelName: String) -> UILabel
    {
        let label = UILabel()
        label.text = labelName
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    /// Helper func to setup UIView for separator
    ///
    /// - Returns: 
    func setupSeparatView() -> UIView
    {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    /// Helper func to setup UITextField
    ///
    /// - Parameter labelName:
    /// - Returns:
    func setupTextField(labelName: String) -> UITextField
    {
        let tf = UITextField()
        tf.placeholder = labelName
        // First letter no loger capialized
        tf.autocapitalizationType = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }
    
    @objc func searchPlace()
    {
        let navController = UINavigationController(rootViewController: MapController())
        self.present(navController, animated: true, completion: nil)
        
//        self.present(MapController(), animated: true, completion: nil)
    }
    
    @objc func goBackToHomeFeed()
    {
        self.dismiss(animated: true, completion: nil)
    }
}
