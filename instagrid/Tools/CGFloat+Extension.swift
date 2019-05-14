//
//  CGFloat+Extension.swift
//  instagrid
//
//  Created by Anne-Elisabeth on 12/05/2019.
//  Copyright © 2019 Anne-Elisabeth. All rights reserved.
//

import Foundation
import UIKit


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
