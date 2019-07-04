//
//  NotificationBuilder.swift
//  PrettyNotify
//
//  Created by Niklas Reinhard on 02.07.19.
//  Copyright © 2019 Niklas Reinhard. All rights reserved.
//

import Foundation

public class NotificationBuilder{
    static var notification: Notification = Notification()
    
    private init(){}
    
    public static func setTitle(_ title: String) -> NotificationBuilder.Type{
        notification.title = title
        return self
    }
    
    public static func setSubtitle(_ subtitle: String) -> NotificationBuilder.Type{
        notification.subtitle = subtitle
        return self
    }
    
    public static func showIcon() -> NotificationBuilder.Type {
        print("yet to be implemented...")
        return self
    }
    
    public static func setCompletionHandler(completion: @escaping (DismissType)->()) -> NotificationBuilder.Type{
        notification.completion = completion
        return self
    }
    
    public static func build() -> Notification{
        if notification.timeout == nil{
            notification.timeout = 10_000
        }
        setCurrentViewController()
        let n = self.notification
        self.notification = Notification()
        return n
    }
    
    public static func setTheme(_ theme: Theme) -> NotificationBuilder.Type{
        notification.theme = theme
        return self
    }
    
    public static func setTimeout(_ timeout: Int) -> NotificationBuilder.Type{
        notification.timeout = timeout
        return self
    }
    
    public static func isDismissable() -> NotificationBuilder.Type{
        notification.dismissGestureRecognizer()
        return self
    }
    
    public static func setPrimaryButton(text: String, action: @escaping ()->()) -> NotificationBuilder.Type{
        notification.primaryButtonText = text
        notification.primaryButtonAction = action
        return self
    }
    
    public static func setSecondaryButton(text: String, action: @escaping ()->()) -> NotificationBuilder.Type{
        notification.secondaryButtonText = text
        notification.secondaryButtonAction = action
        return self
    }
    
    static func setCurrentViewController() {
        if let rootView = UIApplication.shared.keyWindow?.rootViewController{
            notification.parentVC = rootView
        }
    }
}
