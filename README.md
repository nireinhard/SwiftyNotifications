# SwiftyNotifications

Easy to use in app notification library for your app.

[![demobf322ea4fc483576.gif](https://s3.gifyu.com/images/demobf322ea4fc483576.gif)](https://gifyu.com/image/EdvD)

# Usage

```swift
let notification = NotificationBuilder
            .setTheme(NotificationType.error)
            .setTitle("💀 Error")
            .setSubtitle("Something bad happened")
            .isDismissable()
            .setPrimaryButton(text: "Report", action: {})
            .setSecondaryButton(text: "Close", action: {})
            .setTimeout(20_000)
            .showIcon()
            .setCompletionHandler(completion: { (type) in
                switch type{
                case .closeTapped:
                    // action
                    break
                case .primaryButtonTapped:
                    // action
                    break
                case .secondaryButtonTapped:
                    // action
                    break
                case .timeoutReached:
                    // action
                    break
                case .swipeUp:
                    // action
                    break
                }
            })
            .build()

notification.show()
```
