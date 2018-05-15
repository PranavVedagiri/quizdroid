//
//  Account+extension.swift
//  Gage
//
//  Created by Zac on 1/12/18.
//  Copyright © 2018 Zac. All rights reserved.
//

import Foundation

extension AccountController
{
    func setupProfileImageView()
    {
        view.addSubview(profileImageView)
        profileImageRadius = view.frame.width / 5
        
        // make it rounded
        profileImageView.layer.cornerRadius = profileImageRadius / 2
        profileImageView.layer.masksToBounds = true
        
        profileImageView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageRadius).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageRadius).isActive = true
    }
    
    /// Add constrants for x, y, width, and height for inputContainerView
    func setupInputContainerView()
    {
        view.addSubview(inputContainerView)
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        // width is frame's width -20 pixels, 10 to each boundry
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        inputContainerView.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        
        setupEmailInfoDisplay()
        setupUserNameInfoDisplay()
        setupPhoneInfoDisplay()
    }
    
    func setupEmailInfoDisplay()
    {
        guard let emailLabel = emailLabel,
            let emailInfoLabel = emailInfoLabel,
            let emailsSeparatorView = emailsSeparatorView
            else { return }
        
        inputContainerView.addSubview(emailLabel)
        inputContainerView.addSubview(emailInfoLabel)
        inputContainerView.addSubview(emailsSeparatorView)
        
        // 10 pixels away from inputerContainerView's boundry
        emailLabel.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 10).isActive = true
        // 10 pixels below inputContainerView
        emailLabel.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        // width is same as inputContainerView
        emailLabel.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailLabel.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1 / 6).isActive = true
        
        // 10 pixels away from inputerContainerView's boundry
        emailInfoLabel.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 10).isActive = true
        // 10 pixels below inputContainerView
        emailInfoLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor).isActive = true
        // width is same as inputContainerView
        emailInfoLabel.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailInfoLabel.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1 / 6).isActive = true
        
        // email separator constrain
        emailsSeparatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        emailsSeparatorView.topAnchor.constraint(equalTo: emailInfoLabel.bottomAnchor).isActive = true
        emailsSeparatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailsSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupUserNameInfoDisplay()
    {
        guard let userNamelLabel = userNamelLabel,
            let userNameInfoLabel = userNameInfoLabel,
            let userNameSeparatorView = userNameSeparatorView
            else { return }
        
        inputContainerView.addSubview(userNamelLabel)
        inputContainerView.addSubview(userNameInfoLabel)
        inputContainerView.addSubview(userNameSeparatorView)
        
        // 10 pixels away from inputerContainerView's boundry
        userNamelLabel.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 10).isActive = true
        // 10 pixels below inputContainerView
        userNamelLabel.topAnchor.constraint(equalTo: (emailInfoLabel?.bottomAnchor)!).isActive = true
        // width is same as inputContainerView
        userNamelLabel.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        userNamelLabel.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1 / 6).isActive = true
        
        // 10 pixels away from inputerContainerView's boundry
        userNameInfoLabel.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 10).isActive = true
        // 10 pixels below inputContainerView
        userNameInfoLabel.topAnchor.constraint(equalTo: userNamelLabel.bottomAnchor).isActive = true
        // width is same as inputContainerView
        userNameInfoLabel.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        userNameInfoLabel.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1 / 6).isActive = true
        
        // name separator constrain
        userNameSeparatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        userNameSeparatorView.topAnchor.constraint(equalTo: userNameInfoLabel.bottomAnchor).isActive = true
        userNameSeparatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        userNameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupPhoneInfoDisplay()
    {
        guard let phoneLabel = phoneLabel,
            let phoneInfoLabel = phoneInfoLabel,
            let phoneSeparatorView = phoneSeparatorView
            else { return }
        
        inputContainerView.addSubview(phoneLabel)
        inputContainerView.addSubview(phoneInfoLabel)
        inputContainerView.addSubview(phoneSeparatorView)
        
        // 10 pixels away from inputerContainerView's boundry
        phoneLabel.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 10).isActive = true
        // 10 pixels below inputContainerView
        phoneLabel.topAnchor.constraint(equalTo: (userNameInfoLabel?.bottomAnchor)!).isActive = true
        // width is same as inputContainerView
        phoneLabel.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        phoneLabel.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1 / 6).isActive = true
        
        // 10 pixels away from inputerContainerView's boundry
        phoneInfoLabel.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 10).isActive = true
        // 10 pixels below inputContainerView
        phoneInfoLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor).isActive = true
        // width is same as inputContainerView
        phoneInfoLabel.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        phoneInfoLabel.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1 / 6).isActive = true
        
        // phone separator constrain
        phoneSeparatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        phoneSeparatorView.topAnchor.constraint(equalTo: phoneInfoLabel.bottomAnchor).isActive = true
        phoneSeparatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        phoneSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    /// Add constrants for x, y, width, and height for notificationButton
    func setupNotificationButton()
    {
        view.addSubview(notificationButton)
        notificationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // 10 pixels below inputContainerView
        notificationButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 10).isActive = true
        // width is same as inputContainerView
        notificationButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        notificationButton.heightAnchor.constraint(equalToConstant: view.frame.height / 10).isActive = true
    }
    
    func setupPrivatePolicyButton()
    {
        view.addSubview(privatePolicyButton)
        privatePolicyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // 10 pixels below inputContainerView
        privatePolicyButton.topAnchor.constraint(equalTo: notificationButton.bottomAnchor, constant: 10).isActive = true
        // width is same as inputContainerView
        privatePolicyButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        privatePolicyButton.heightAnchor.constraint(equalToConstant: view.frame.height / 10).isActive = true
    }
}
