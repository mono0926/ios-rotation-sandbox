//
//  UIView+Autolayout.swift
//  ios-rotation-sandbox
//
//  Created by mono on 4/29/15.
//  Copyright (c) 2015 mono. All rights reserved.
//

import Foundation
extension UIView {
    func bindToSuperView() {
        let frame = superview!.frame
        mas_makeConstraints { make in
            // MasonryはSwiftだと構文がおかしいのでCartography or Snappy推奨
            make.edges.equalTo()(self.superview!).with().insets()(UIEdgeInsetsZero)
            return
        }
    }
}