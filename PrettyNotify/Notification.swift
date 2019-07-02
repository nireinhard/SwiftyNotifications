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
    var showIcon: Bool = false
    var parentVC: UIViewController?
    var theme: Theme? = nil
    var timeout: Int? = nil
    var view: UIView = UIView()
    var app: UIApplication?

    var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    public func show(){
        setupView()
        if let vc = parentVC{
            view.alpha = 0.0
            vc.view.addSubview(view)
            UIView.animate(withDuration: 0.5, animations: {
                self.view.alpha = 1.0
            }) { (finished) in
                if finished{
                    if let timeout = self.timeout{
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(timeout)) {
                            self.dismissView()
                        }
                    }
                }
            }
        }
    }
    
    func dismissView(fastDismiss: Bool = false){
        UIView.animate(withDuration: fastDismiss ? 0.1 : 0.5, animations: {
            self.view.alpha = 0.0
        }) { (finished) in
            if finished{
                self.view.removeFromSuperview()
            }
        }
    }
    
    func dismissGestureRecognizer(){
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
    }
    
    func setupView(){
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(rgb: theme?.color ?? 0x9C64A6)
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
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(subtitleLabel)
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
        }
        if let secondaryButtonText = secondaryButtonText{
            secondaryButton.setTitle(secondaryButtonText, for: .normal)
            buttonStackView.addArrangedSubview(secondaryButton)
        }
    }
    
    @objc func handleSwipe(){
        dismissView(fastDismiss: true)
    }
    
    @objc func handlePrimaryButton(){
        if let primaryButtonAction = primaryButtonAction{
            primaryButtonAction()
            dismissView()
        }
    }
    
    @objc func handleSecondaryButton(){
        if let secondaryButtonAction = secondaryButtonAction{
            secondaryButtonAction()
            dismissView()
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
