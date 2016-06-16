//
//  LoginView.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 6/8/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Cocoa

class LoginView: NSViewController {

    @IBOutlet weak var loginTextField       : NSTextField!
    @IBOutlet weak var passwordTextField    : NSSecureTextField!
    @IBOutlet weak var errorLabel           : NSTextField!
    @IBOutlet weak var loginButton          : NSButton!
    
    private let _authentication             = Authentication()
    
    private var _timer                      : NSTimer?
    private let _reachability               = Reachability()
    
    var navigatorDelegate                   : INavigatorDelegate?
    var reachabilityDelegate                : IReachabilityDelegate?
    
    override func awakeFromNib() {
        startCheckReachability()
    }
    
    @IBAction func loginPressed(sender: NSButton) {
        let login       = loginTextField.stringValue
        let password    = passwordTextField.stringValue
        
        Animations.startScaleAnimation(loginButton)
        if login.isEmpty || password.isEmpty {
            if login.isEmpty {
                Animations.startShakeAnimation(loginTextField)
            }
            if password.isEmpty {
                Animations.startShakeAnimation(passwordTextField)
            }
            return
        }
        Animations.startSpinningAnimation(loginButton)
        _authentication.authenticate(login, password: password.md5(),
                                     onSuccess: authenticationSucceed,
                                     onErrors: authenticationFailed)
    }
    
    private func authenticationSucceed(user: User) {
        reachabilityDelegate?.isReachable()
        UserStorage.user = user
        navigatorDelegate?.refreshUI()
        loginButton.layer?.removeAnimationForKey(Animations.ROTATE_KEY)
    }
    
    private func authenticationFailed(errors: [Error]) {
        if let error = errors.first {
            if error.code == 0 {
                reachabilityDelegate?.isUnreachable()
                startCheckReachability()
            }
            errorLabel.stringValue = error.reason
            Animations.startOpacityAnimation(errorLabel)
            loginButton.layer?.removeAnimationForKey(Animations.ROTATE_KEY)
        }
    }
    
}

extension LoginView {
    
    private func startCheckReachability() {
        _timer?.invalidate()
        _timer = NSTimer(timeInterval: 10, target: self, selector:
            #selector(LoginView.checkReachability), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(_timer!, forMode: NSRunLoopCommonModes)
        checkReachability()
    }
    
    @objc
    private func checkReachability() {
        _reachability.Ping({
            self.reachabilityDelegate?.isReachable()
            self._timer?.invalidate()
            }) {
            self.reachabilityDelegate?.isUnreachable()
        }
    }
    
}