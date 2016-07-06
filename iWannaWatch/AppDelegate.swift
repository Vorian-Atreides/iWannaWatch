//
//  AppDelegate.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 5/22/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationWillBecomeActive(notification: NSNotification) {
        NSNotificationCenter.defaultCenter().postNotificationName("ACTIVATE", object: nil)
    }
    
}

