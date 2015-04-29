//
//  ModalViewController1.swift
//  ios-rotation-sandbox
//
//  Created by mono on 4/29/15.
//  Copyright (c) 2015 mono. All rights reserved.
//

import Foundation
import UIKit
class ModalViewController1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allowRotation = true
    }
    @IBAction func closeDidTap(button: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}