//
//  NavigationViewController.swift
//  CognitoYourUserPoolsSample
//
//  Created by Martin Chibwe on 5/6/18.
//  Copyright © 2018 Dubal, Rohan. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }



}
