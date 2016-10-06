//
//  AppDelegate.swift
//  codequiz
//
//  Created by Marcos Polanco on 9/24/16.
//  Copyright © 2016 Visor Labs. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //Install Firebase
        FIRApp.configure()
        
        //Install Facebook
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

        
        Threads.onMain{
            Database.sharedInstance.data()
            //Database.sharedInstance.jstr().log()
        }
        
        return true
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
}

