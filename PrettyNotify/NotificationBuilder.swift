//
//  NotificationBuilder.swift
//  PrettyNotify
//
//  Created by Niklas Reinhard on 02.07.19.
//  Copyright © 2019 Niklas Reinhard. All rights reserved.
//

import Foundation

public class NotificationBuilder{
    var notification: Notification?
    
    public init(){
        self.notification = Notification()
    }
    
    public func setTitle(_ title: String) -> NotificationBuilder{
        notification?.title = title
        return self
    }
    
    public func setSubtitle(_ subtitle: String) -> NotificationBuilder{
        notification?.subtitle = subtitle
        return self
    }
    
    public func showIcon() -> NotificationBuilder {
        print("yet to be implemented...")
        return self
    }
    
    public func setCompletionHandler(completion: @escaping (DismissType)->()) -> NotificationBuilder{
        notification?.completion = completion
        return self
    }
    
    public func build() -> Notification{
        if notification?.timeout == nil{
            notification?.timeout = 10_000
        }
        setCurrentViewController()
        if let notification = notification{
            return notification
        }else{
            return Notification()
        }
    }
    
    public func setTheme(_ theme: Theme) -> NotificationBuilder{
        notification?.theme = theme
        return self
    }
    
    public func setTimeout(_ timeout: Int) -> NotificationBuilder{
        notification?.timeout = timeout
        return self
    }
    
    public func isDismissable() -> NotificationBuilder{
        notification?.dismissGestureRecognizer()
        return self
    }
    
    public func setPrimaryButton(text: String, action: @escaping ()->()) -> NotificationBuilder{
        notification?.primaryButtonText = text
        notification?.primaryButtonAction = action
        return self
    }
    
    public func setSecondaryButton(text: String, action: @escaping ()->()) -> NotificationBuilder{
        notification?.secondaryButtonText = text
        notification?.secondaryButtonAction = action
        return self
    }
    
    func setCurrentViewController() {
        if let rootView = UIApplication.shared.keyWindow?.rootViewController{
            notification?.parentVC = rootView
        }
    }
}
