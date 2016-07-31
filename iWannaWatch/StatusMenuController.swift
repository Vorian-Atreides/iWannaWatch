//
//  StatusMenuController.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 6/1/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObjectController {

    @IBOutlet weak var StatusMenu       : NSMenu!
    @IBOutlet weak var mainMenuItem     : NSMenuItem!
    @IBOutlet weak var serviceMenu      : StatusServiceView!
    
    @IBOutlet weak var loginTextField   : NSTextField!
    @IBOutlet weak var logoutButton     : NSButton!
    
    private var statusItem              = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    private var controller              : MainView?
    
    override func awakeFromNib() {
        NSNotificationCenter.defaultCenter()
            .addObserver(self, selector: #selector(hasLogged), name: "Logged", object: nil)
        refreshUI()
    }
    
    private func initialiseStatusMenuItem() {
        let icon            = NSImage(named: "statusIcon")
        icon?.template      = true
        statusItem.image    = icon
        statusItem.menu     = StatusMenu
    }
    
    @objc
    private func hasLogged() {
        refreshUI()
    }
    
    func refreshUI() {
        if UserStorage.token != nil {
            initialiseStatusMenuItem()
            controller = MainView()
            controller?.delegate        = self
            loginTextField.stringValue  = UserStorage.user?.login ?? ""
            
            NSApp.setActivationPolicy(NSApplicationActivationPolicy.Prohibited)
        } else {
            statusItem.image = nil
            NSApp.setActivationPolicy(NSApplicationActivationPolicy.Regular)
            NSApp.activateIgnoringOtherApps(true)
        }
        
        mainMenuItem.view = controller?.view
    }
    
    @IBAction func logoutClicked(sender: NSButton) {
        UserStorage.clear()
        refreshUI()
    }

}

extension StatusMenuController: IReachabilityDelegate {
    
    func isUnreachable() {
        serviceMenu.State = StatusServiceView.Reachability.UnReachable
    }
    
    func isReachable() {
        serviceMenu.State = StatusServiceView.Reachability.Reachable
    }
    
}