//
//  Notification.swift
//  PrettyNotify
//
//  Created by Niklas Reinhard on 02.07.19.
//  Copyright © 2019 Niklas Reinhard. All rights reserved.
//

import Foundation

public class Notification{
    var title: String? = nil
    var subtitle: String? = nil
    var primaryButtonText: String? = nil
    var primaryButtonAction: (()->())? = nil
    var secondaryButtonText: String? = nil
    var secondaryButtonAction: (()->())? = nil
    var dismissGestureRecognizer: UIGestureRecognizer? = nil
    var parentVC: UIViewController?
    var context: NotificationType? = nil
    var view: UIView = UIView()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    public func show(){
        setupView()
        if let vc = parentVC{
            print("\(String(describing: title))\n\(String(describing: subtitle))")
            vc.view.addSubview(view)
        }
    }
    
    
    func setupView(){
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(rgb: 0x9C64A6)
        setupLabels()
        setupButtons()
        contentStackView.addArrangedSubview(buttonStackView)
        view.addSubview(contentStackView)
        contentStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        contentStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        contentStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        setupViewConstraints()
    }
    
    func setupLabels(){
        let titleLabel = UILabel()
        let subtitleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.textColor = .white
        subtitleLabel.text = subtitle
        subtitleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //view.addSubview(titleLabel)
        //view.addSubview(subtitleLabel)
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(subtitleLabel)
        
//        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
//        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
//        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
//
        if subtitle != nil{
//            titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3, constant: -10).isActive = true
//            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
//            subtitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
//            subtitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
//            subtitleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3, constant: -20).isActive = true
        }else{
//            titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1, constant: -25).isActive = true
        }
    }
    
    func setupButtons(){
        let primaryButton = UIButton()
        let secondaryButton = UIButton()
        primaryButton.translatesAutoresizingMaskIntoConstraints = false
        secondaryButton.translatesAutoresizingMaskIntoConstraints = false
        primaryButton.addTarget(self, action: #selector(handlePrimaryButton), for: .touchUpInside)
        secondaryButton.addTarget(self, action: #selector(handleSecondaryButton), for: .touchUpInside)
        if let primaryButtonText = primaryButtonText{
            primaryButton.setTitle(primaryButtonText, for: .normal)
            
            buttonStackView.addArrangedSubview(primaryButton)
//            primaryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//            primaryButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//            primaryButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
//            primaryButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        }
        if let secondaryButtonText = secondaryButtonText{
            secondaryButton.setTitle(secondaryButtonText, for: .normal)
            
            buttonStackView.addArrangedSubview(secondaryButton)
//            secondaryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//            secondaryButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//            secondaryButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
//            secondaryButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        }
    }
    
    @objc func handlePrimaryButton(){
        if let primaryButtonAction = primaryButtonAction{
            primaryButtonAction()
        }
    }
    
    @objc func handleSecondaryButton(){
        if let secondaryButtonAction = secondaryButtonAction{
            secondaryButtonAction()
        }
    }
    
    func calculateViewHeight() -> CGFloat{
        var height: Float = 80.0
        if primaryButtonText != nil || secondaryButtonText != nil{
            height = 120.0
        }
        return CGFloat(height)
    }
    
    func setupViewConstraints(){
        if let parentVC = parentVC{
            parentVC.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.topAnchor.constraint(equalTo: parentVC.view.safeAreaLayoutGuide.topAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: parentVC.view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
            view.leftAnchor.constraint(equalTo: parentVC.view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
            view.heightAnchor.constraint(equalToConstant: calculateViewHeight()).isActive = true
        }
    }
}
