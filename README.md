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
                if type == .primaryButtonTapped{
                    print("primary button tapped")
                }
                if type == .timeoutReached{
                    print("timeout reached")
                }
                if type == .swipeUp{
                    print("swipe up")
                }
                if type == .closeTapped{
                    print("close tapped")
                }
            })
            .build()

notification.show()
```
