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
    var view: NotificationView = NotificationView()
    var completion: ((DismissType)->())? = nil
    var topAnchor: NSLayoutConstraint?
    
    private lazy var dismissViewTimeoutReached = DispatchWorkItem(block: {
        self.dismissView(.timeoutReached)
    })
    
    var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var closeItemButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let bundle = Bundle(identifier: "NiklasR.PrettyNotify")
        let path = bundle?.path(forResource: "close", ofType: "png")
        let data = NSData(contentsOfFile: path!)
        if let data = data as Data?{
            button.setImage(UIImage(data: data), for: .normal)
            button.addTarget(self, action: #selector(closeButtonTappedAction), for: .touchUpInside)
        }
        button.widthAnchor.constraint(equalToConstant: 32).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return button
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
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(timeout), execute: self.dismissViewTimeoutReached)
                    }
                }
            }
        }
    }
    

    func dismissView(fastDismiss: Bool = false, _ dismissType: DismissType){
        UIView.animate(withDuration: fastDismiss ? 0.1 : 0.5, animations: {
            self.view.alpha = 0.0
        }) { (finished) in
            if finished{
                self.view.removeFromSuperview()
                self.updateTopAnchor()
                self.dismissViewTimeoutReached.cancel()
                self.completion?(dismissType)
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
        view.backgroundColor = UIColor(rgb: theme?.primaryColor ?? 0x9C64A6)
        setupShadow()
        setupLabels()
        setupButtons()
        view.addSubview(contentStackView)
        contentStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        contentStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        contentStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        setupViewConstraints()
    }
    
    func setupShadow(){
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 6
    }
    
    func setupLabels(){
        let titleLabel = UILabel()
        let subtitleLabel = UILabel()
        subtitleLabel.numberOfLines = 0
        subtitleLabel.lineBreakMode = .byWordWrapping
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.textColor = .white
        subtitleLabel.text = subtitle
        subtitleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(closeItemButton)
        
        contentStackView.addArrangedSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: contentStackView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentStackView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentStackView.rightAnchor).isActive = true
        
        contentStackView.addArrangedSubview(subtitleLabel)
    }
    
    func setupButtons(){
        guard primaryButtonText != nil || secondaryButtonText != nil else {
            return
        }
        let primaryButton = UIButton()
        let secondaryButton = UIButton()
        primaryButton.translatesAutoresizingMaskIntoConstraints = false
        secondaryButton.translatesAutoresizingMaskIntoConstraints = false
        primaryButton.addTarget(self, action: #selector(handlePrimaryButton(sender:)), for: .touchUpInside)
        secondaryButton.addTarget(self, action: #selector(handleSecondaryButton(sender:)), for: .touchUpInside)
        primaryButton.layer.cornerRadius = 10
        secondaryButton.layer.cornerRadius = 10
        if let theme = theme{
            primaryButton.backgroundColor = UIColor(rgb: theme.secondaryColor)
            secondaryButton.backgroundColor = UIColor(rgb: theme.secondaryColor)
        }
        if let primaryButtonText = primaryButtonText{
            primaryButton.setTitle(primaryButtonText, for: .normal)
            buttonStackView.addArrangedSubview(primaryButton)
        }
        if let secondaryButtonText = secondaryButtonText{
            secondaryButton.setTitle(secondaryButtonText, for: .normal)
            buttonStackView.addArrangedSubview(secondaryButton)
        }
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(containerView)
        containerView.rightAnchor.constraint(equalTo: contentStackView.rightAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: contentStackView.leftAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        containerView.addSubview(buttonStackView)
        buttonStackView.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        buttonStackView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        buttonStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
    }
    
    @objc func closeButtonTappedAction(){
        dismissView(.closeTapped)
    }
    
    @objc func handleSwipe(){
        dismissView(fastDismiss: true, .swipeUp)
    }
    
    @objc func handlePrimaryButton(sender: Any){
        if let primaryButtonAction = primaryButtonAction{
            primaryButtonAction()
        }
        dismissView(.primaryButtonTapped)
    }
    
    @objc func handleSecondaryButton(sender: Any){
        if let secondaryButtonAction = secondaryButtonAction{
            secondaryButtonAction()
        }
        dismissView(.secondaryButtonTapped)
    }
    
    func updateTopAnchor(){
        if let parentVC = parentVC{
            let notificationViews = parentVC.view.subviews.filter({$0.isKind(of: NotificationView.self)})
            print(notificationViews)
            let con: CGFloat = 20
            notificationViews.first?.topAnchor.constraint(equalTo: parentVC.view.safeAreaLayoutGuide.topAnchor, constant: con).isActive = true
            for (i, view) in notificationViews.dropFirst().enumerated(){
                view.topAnchor.constraint(equalTo: parentVC.view.safeAreaLayoutGuide.topAnchor, constant: calculateTopAnchorPartial(notificationViews,i)).isActive = true
                view.setNeedsLayout()
                view.layoutIfNeeded()
            }
        }
    }
    
    func calculateTopAnchorPartial(_ notificationViews: [UIView], _ index: Int) -> CGFloat{
        var topAnchor: CGFloat = 20
        for i in 0...index{
            topAnchor+=notificationViews[i].frame.height + 5
        }
        return topAnchor
    }

    func calculateTopAnchor() -> CGFloat{
        let topAnchor: CGFloat = 20
        if let parentVC = parentVC{
            let marginBetweenNotifications: CGFloat = 5
            return parentVC.view.subviews.filter({ $0.isKind(of: NotificationView.self) }).reduce(topAnchor, {$0 + $1.frame.height + marginBetweenNotifications})
        }
        return topAnchor
    }
    
    func setupViewConstraints(){
        if let parentVC = parentVC{
            parentVC.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            let topAnchor = view.topAnchor.constraint(equalTo: parentVC.view.safeAreaLayoutGuide.topAnchor, constant: calculateTopAnchor())
            topAnchor.priority = UILayoutPriority(rawValue: 999)
            topAnchor.isActive = true
            view.rightAnchor.constraint(equalTo: parentVC.view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
            view.leftAnchor.constraint(equalTo: parentVC.view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
            view.setContentHuggingPriority(.init(1000), for: .vertical)
        }
    }
}
