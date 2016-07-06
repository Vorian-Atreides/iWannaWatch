//
//  StatusMenuController.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 6/1/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObjectController, INavigatorDelegate {

    @IBOutlet weak var StatusMenu       : NSMenu!
    @IBOutlet weak var mainMenuItem     : NSMenuItem!
    @IBOutlet weak var serviceMenu      : StatusServiceView!
    
    @IBOutlet weak var loginTextField   : NSTextField!
    @IBOutlet weak var logoutButton     : NSButton!
    
    private var _statusItem             = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    
    private var _mainController         : NSViewController?
    
    override func awakeFromNib() {
        let icon            = NSImage(named: "statusIcon")
        icon?.template      = true
        _statusItem.image   = icon
        _statusItem.menu    = StatusMenu
        
        handleActivationIssue()
        refreshUI()
    }
    
    func refreshUI() {
        if UserStorage.token == nil {
            _mainController         = LoginView()
            loginTextField.hidden   = true
            logoutButton.hidden     = true
            (_mainController as? LoginView)?.navigatorDelegate = self
            (_mainController as? LoginView)?.reachabilityDelegate = self
        } else {
            _mainController = MainView()
            loginTextField.hidden       = false
            logoutButton.hidden         = false
            loginTextField.stringValue  = UserStorage.user?.login ?? ""
            (_mainController as? MainView)?.delegate = self
        }
        
        mainMenuItem.view = _mainController?.view
        startViewTransition(mainMenuItem.view)
    }
    
    @IBAction func logoutClicked(sender: NSButton) {
        UserStorage.clear()
        refreshUI()
    }
    
    private var activated = false
}

extension StatusMenuController {
    
    // Succeed to find a hack to replace the lack of makeKeyWindow which doesn't work
    // with a NSStatutBarWindow
    private func handleActivationIssue() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onActivate), name: "ACTIVATE", object: nil)
        let click = NSClickGestureRecognizer(target: self, action: #selector(onClick))
        _statusItem.button?.addGestureRecognizer(click);
    }
    
    @objc
    private func onClick() {
        
        if ((_mainController as? LoginView) != nil && !NSRunningApplication.currentApplication().active) {
            dispatch_async(dispatch_get_main_queue()) { [weak self] in
                self?.activated = true
                NSRunningApplication.currentApplication().activateWithOptions(NSApplicationActivationOptions.ActivateIgnoringOtherApps)
            }
        } else {
            _statusItem.popUpStatusItemMenu(StatusMenu)
        }
    }
    
    @objc
    private func onActivate() {
        if (activated) {
            activated = false
            dispatch_async(dispatch_get_main_queue()) { [weak self] in
                if let s = self {
                    s._statusItem.popUpStatusItemMenu(s.StatusMenu)
                }
            }
        }
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

extension StatusMenuController {
    
    private func startViewTransition(view: NSView?) {
        let transition              = CATransition()
        
        transition.startProgress    = 0
        transition.endProgress      = 1
        transition.duration         = 0.25
        transition.type             = kCATransitionMoveIn
        transition.subtype          = kCATransitionFromLeft
        
        view?.layer?.addAnimation(transition, forKey: "transition")
    }
    
}