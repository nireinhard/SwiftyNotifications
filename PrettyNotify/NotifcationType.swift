//
// Created by Niklas Reinhard on 2019-07-02.
// Copyright (c) 2019 Niklas Reinhard. All rights reserved.
//

import Foundation

public struct Theme{
    let color: Int
    let icon: String
}

public struct NotificationType{
    public static let info = Theme(color: 0x2980B9, icon: "")
    public static let error = Theme(color: 0xE74C3C, icon: "")
    public static let warning = Theme(color: 0xF39C12, icon: "")
    public static let success = Theme(color: 0x27AE60, icon: "")
}
