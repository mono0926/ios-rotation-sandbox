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
        // for WebView full screen movie
        ObjcHelper.aspect_viewControllerHookSelector("viewDidLoad", withOptions: .PositionBefore, error: &error) { info in
            let vc = info.instance() as! UIViewController
            if ObjcHelper.isFullScreenAVPlayer(vc) {
                vc.allowRotation = true
            }
        }
        assert(error == nil)
        // setting allowRotation
        ObjcHelper.aspect_viewControllerHookSelector("viewWillAppear:", withOptions: .PositionBefore, error: &error) { info in
            let vc = info.instance() as! UIViewController
            if !vc.isCustom() && !vc.allowRotation {
                return
            }
            self.allowRotation = vc.allowRotation
        }
        assert(error == nil)
        // handle dismiss
        ObjcHelper.aspect_navigationControllerHookSelector("popViewControllerAnimated:", withOptions: .PositionBefore, error: &error) { info in
            let vc = info.instance() as! UINavigationController
            let vcs = vc.viewControllers
            self.allowRotation = (vcs[vcs.count - 2] as! UIViewController).allowRotation
        }
        assert(error == nil)
        ObjcHelper.aspect_viewControllerHookSelector("dismissViewControllerAnimated:completion:", withOptions: .PositionBefore, error: &error) { info in
            let vc = info.instance() as! UIViewController
            if let presentingViewController = vc.presentingViewController {
                self.allowRotation = presentingViewController.allowRotation
            }
            // When WebView full screen movie disappearing, no event occured...
            if ObjcHelper.isFullScreenAVPlayer(vc) && !self.allowRotation {
                UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
            }
        }
        assert(error == nil)
        // override supportedInterfaceOrientations to return allowRotation managed by AppDelegate
        ObjcHelper.aspect_viewControllerHookSelector("supportedInterfaceOrientations", withOptions: .PositionInstead, error: &error) { info in
            let vc = info.instance() as! UIViewController
            let invocation = info.originalInvocation()
            var ret = Int(self.allowRotation ? UIInterfaceOrientationMask.AllButUpsideDown.rawValue : UIInterfaceOrientationMask.Portrait.rawValue)
            invocation.setReturnValue(&ret)
        }
        assert(error == nil)
    }

    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> Int {
        return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
    }
}

