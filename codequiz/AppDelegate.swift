//
//  AppDelegate.swift
//  codequiz
//
//  Created by Marcos Polanco on 9/24/16.
//  Copyright © 2016 Visor Labs. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        Threads.onMain{
            Database.sharedInstance.data()
            //Database.sharedInstance.jstr().log()
        }
        
        return true
    }
}

