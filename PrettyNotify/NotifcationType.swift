//
// Created by Niklas Reinhard on 2019-07-02.
// Copyright (c) 2019 Niklas Reinhard. All rights reserved.
//

import Foundation

public struct Theme{
    let primaryColor: Int
    let secondaryColor: Int
    let icon: String
}

public struct NotificationType{
    public static let info = Theme(primaryColor: 0x2980B9, secondaryColor: 0x2576AC, icon: "")
    public static let error = Theme(primaryColor: 0xE74C3C, secondaryColor: 0xCC302B, icon: "")
    public static let warning = Theme(primaryColor: 0xF39C12, secondaryColor: 0xea9512, icon: "")
    public static let success = Theme(primaryColor: 0x27AE60, secondaryColor: 0x229E58, icon: "")
}
