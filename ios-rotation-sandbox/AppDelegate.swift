//
//  AppDelegate.swift
//  ios-rotation-sandbox
//
//  Created by mono on 4/28/15.
//  Copyright (c) 2015 mono. All rights reserved.
//

import UIKit
import AVKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var allowRotation = false


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        hookForRotation()
        return true
    }
    
    private func hookForRotation() {
        var error: NSError? = nil
        do {
            // for WebView full screen movie
            try ObjcHelper.aspect_viewControllerHookSelector("viewDidLoad", withOptions: .PositionBefore) { info in
                let vc = info.instance() as! UIViewController
                if ObjcHelper.isFullScreenAVPlayer(vc) {
                    vc.allowRotation = true
                }
            }
        } catch let error1 as NSError {
            error = error1
        }
        assert(error == nil)
        do {
            // setting allowRotation
            try ObjcHelper.aspect_viewControllerHookSelector("viewWillAppear:", withOptions: .PositionBefore) { info in
                let vc = info.instance() as! UIViewController
                if !vc.isCustom() && !vc.allowRotation {
                    return
                }
                self.allowRotation = vc.allowRotation
            }
        } catch let error1 as NSError {
            error = error1
        }
        assert(error == nil)
        do {
            // handle dismiss
            try ObjcHelper.aspect_navigationControllerHookSelector("popViewControllerAnimated:", withOptions: .PositionBefore) { info in
                let vc = info.instance() as! UINavigationController
                let vcs = vc.viewControllers
                self.allowRotation = (vcs[vcs.count - 2] ).allowRotation
            }
        } catch let error1 as NSError {
            error = error1
        }
        assert(error == nil)
        do {
            try ObjcHelper.aspect_viewControllerHookSelector("dismissViewControllerAnimated:completion:", withOptions: .PositionBefore) { info in
                let vc = info.instance() as! UIViewController
                if let presentingViewController = vc.presentingViewController {
                    self.allowRotation = presentingViewController.allowRotation
                }
                // When WebView full screen movie disappearing, no event occured...
                if ObjcHelper.isFullScreenAVPlayer(vc) && !self.allowRotation {
                    UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
                }
            }
        } catch let error1 as NSError {
            error = error1
        }
        assert(error == nil)
        do {
            // override supportedInterfaceOrientations to return allowRotation managed by AppDelegate
            try ObjcHelper.aspect_viewControllerHookSelector("supportedInterfaceOrientations", withOptions: .PositionInstead) { info in
                let invocation = info.originalInvocation()
                var ret = Int(self.allowRotation ? UIInterfaceOrientationMask.AllButUpsideDown.rawValue : UIInterfaceOrientationMask.Portrait.rawValue)
                invocation.setReturnValue(&ret)
            }
        } catch let error1 as NSError {
            error = error1
        }
        assert(error == nil)
    }

    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.AllButUpsideDown
    }
}

