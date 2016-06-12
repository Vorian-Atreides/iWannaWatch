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
    
    private let _authentication = Authentication()
    
    var delegate                : INavigatorDelegate?
    
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
        _authentication.authenticate(login, password: password,
                                     onSuccess: authenticationSucceed,
                                     onErrors: authenticationFailed)
    }
    
    private func authenticationSucceed(user: User) {
        UserStorage.user = user
        delegate?.refreshUI()
        loginButton.layer?.removeAnimationForKey(Animations.ROTATE_KEY)
    }
    
    private func authenticationFailed(errors: [Error]) {
        if let error = errors.first {
            errorLabel.stringValue = error.reason
            loginButton.layer?.removeAnimationForKey(Animations.ROTATE_KEY)
            Animations.startOpacityAnimation(errorLabel)
        }
    }
    
}