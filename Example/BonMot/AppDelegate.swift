//
//  AppDelegate.swift
//
//  Created by Brian King on 7/20/16.
//  Copyright © 2016 Raizlabs. All rights reserved.
//

import UIKit
import BonMot

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        style()
        window?.makeKeyAndVisible()
        application.enableAdaptiveContentSizeMonitor()
        return true
    }

    func style() {
        let traitCollection = UIApplication.sharedApplication().keyWindow?.traitCollection
        // Use UIAppearance to configure the font scaling table approach showcased in WWDC 2016 Session 803

        UINavigationBar.appearance().titleTextAttributes = Style().styleAttributes(traitCollection: traitCollection)

        let barStyle = BonMot(.font(UIFont.appFontOfSize(17)), .adapt(.control))
        UIBarButtonItem.appearance().setTitleTextAttributes(barStyle.styleAttributes(traitCollection: traitCollection), forState: .Normal)
    }

}

