//
//  UIColor+Extension.swift
//  instagrid
//
//  Created by Anne-Elisabeth on 12/05/2019.
//  Copyright © 2019 Anne-Elisabeth. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func random() -> UIColor {
        return UIColor(red: CGFloat.random(), green: CGFloat.random(), blue: CGFloat.random(), alpha: 1)
    }
}
