//
//  UIViewController+Rotation.swift
//  ios-rotation-sandbox
//
//  Created by mono on 4/28/15.
//  Copyright (c) 2015 mono. All rights reserved.
//

import Foundation
import UIKit

private var allowRotationKey: UInt8 = 0

extension UIViewController {
    func appDelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    var allowRotation: Bool {
        get { return (objc_getAssociatedObject(self, &allowRotationKey) as? Bool) ?? false }
        set { objc_setAssociatedObject(self, &allowRotationKey, newValue, UInt(OBJC_ASSOCIATION_RETAIN)) }
    }
    func isCustom() -> Bool {
        return NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").count > 1
    }
}