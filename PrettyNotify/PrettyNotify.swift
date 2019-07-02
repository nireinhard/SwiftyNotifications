//
//  PrettyNotify.swift
//  PrettyNotify
//
//  Created by Niklas Reinhard on 02.07.19.
//  Copyright © 2019 Niklas Reinhard. All rights reserved.
//

import Foundation

public class PrettyNotify{

    private init(){}
    
    public static func notify(_ context: UIViewController, with type: NotificationType, message: String) {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        label.text = "Hallo"
        view.addSubview(label)
        
        context.view.addSubview(view)
    
        view.topAnchor.constraint(equalTo: context.view.topAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: context.view.rightAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: context.view.leftAnchor).isActive = true
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            view.removeFromSuperview()
        }
    }
}
