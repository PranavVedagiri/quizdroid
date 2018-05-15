//
//  AccountController.swift
//  Gage
//
//  Created by Zac on 12/26/17.
//  Copyright © 2017 Zac. All rights reserved.
//

import UIKit

class AccountController: UIViewController
{
    var profileImageRadius: CGFloat = 0
    
//    let menuBar: MenuBar = {
//        let menuBar = MenuBar()
//        return menuBar
//    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "curry")
        imageView.contentMode = .scaleAspectFill
        // cut out if out of bounds
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let inputContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let notificationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Notifications", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNotificationPopUp), for: .touchUpInside)
        return button
    }()
    
    let privatePolicyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePrivacyPopUp), for: .touchUpInside)
        return button
    }()
    
    var emailLabel: UILabel?

    var emailInfoLabel: UILabel?
    
    var emailsSeparatorView: UIView?
    
    var userNamelLabel: UILabel?

    var userNameInfoLabel: UILabel?
    
    var userNameSeparatorView: UIView?
    
    var phoneLabel: UILabel?
    
    var phoneInfoLabel: UILabel?
    
    var phoneSeparatorView: UIView?
    
    let navigationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Labels

        emailLabel = setupLabel(labelName: "Email")
        emailInfoLabel = setupLabel(labelName: "stephencurry@gmail.com")
        userNamelLabel = setupLabel(labelName: "Username")
        userNameInfoLabel = setupLabel(labelName: "Stephen Curry")
        phoneLabel = setupLabel(labelName: "Phone")
        phoneInfoLabel = setupLabel(labelName: "(123) 456-7890")

        // Setup Separators

        emailsSeparatorView = setupSeparatView()
        userNameSeparatorView = setupSeparatView()
        phoneSeparatorView = setupSeparatView()
        
        view.backgroundColor = UIColor(red: 200, green: 200, blue: 200)

//        setupMenuBar()
        setupNavigationBar()
        setupInputContainerView()
        setupProfileImageView()
        setupNotificationButton()
        setupPrivatePolicyButton()
    }
    
//    private func setupMenuBar()
//    {
//        view.addSubview(menuBar)
//        view.addConstrainWithFormat(format: "H:|[v0]|", views: menuBar)
//        // MenuBar high is 40 pixels, no bottom constrain
//        view.addConstrainWithFormat(format: "V:|[v0(\(view.frame.height/10))]", views: menuBar)
//        menuBar.backgroundColor = UIColor.blue
//    }
    
    
    private func setupNavigationBar()
    {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        // Remove the line under navigation bar
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        // 10 pixels from left boundry
        let titleLabel = UILabel(frame: CGRect(x: 50, y: 0, width: view.frame.width - 20, height: view.frame.height))
        titleLabel.text = "Account"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        let homeButton = UIButton(type: .system)
        homeButton.setImage(#imageLiteral(resourceName: "home_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        homeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        homeButton.addTarget(self, action: #selector(goBackToHomeFeed), for: .touchUpInside)
        // If only 1 item, use rightBarButtonItem = gearBarButton
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: homeButton)]
    }
    
    @objc private func handlePrivacyPopUp()
    {
        goBackToHomeFeed()
    }
    
    @objc private func handleNotificationPopUp()
    {
        searchPlace()
    }
    
    /// Modified status bar color
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}
