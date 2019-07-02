//
//  NotificationBuilder.swift
//  PrettyNotify
//
//  Created by Niklas Reinhard on 02.07.19.
//  Copyright © 2019 Niklas Reinhard. All rights reserved.
//

import Foundation

public class NotificationBuilder{
    static var notification = Notification()
    private init() {}
    
    public static func setTitle(_ title: String) -> NotificationBuilder.Type{
        notification.title = title
        return self
    }
    
    public static func setSubtitle(_ subtitle: String) -> NotificationBuilder.Type{
        notification.subtitle = subtitle
        return self
    }
    
    public static func build() -> Notification{
        return notification
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
    
    public static func setCurrentViewController(_ vc: UIViewController) -> NotificationBuilder.Type{
        notification.parentVC = vc
        return self
    }
}
