//
//  LoginView.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 6/8/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Cocoa

class LoginView: NSViewController {

    @IBOutlet weak var  loginTextField      : NSTextField!
    @IBOutlet weak var  passwordTextField   : NSSecureTextField!
    @IBOutlet weak var  errorLabel          : NSTextField!
    @IBOutlet weak var  loginButton         : NSButton!
    
    @IBOutlet weak var  loginView           : NSView!
    private let         authentication      = Authentication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        loginView.layer!.backgroundColor = NSColor.whiteColor().CGColor
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
        authentication.authenticate(login, password: password.md5(),
                                     onSuccess: authenticationSucceed,
                                     onErrors: authenticationFailed)
    }
    
    private func authenticationSucceed(user: User) {
        UserStorage.user = user
        loginButton.layer?.removeAnimationForKey(Animations.ROTATE_KEY)
        
        NSNotificationCenter.defaultCenter().postNotificationName("Logged", object: nil, userInfo: nil)
    }
    
    private func authenticationFailed(errors: [Error]) {
        if let error = errors.first {
            errorLabel.stringValue = error.reason ?? ""
            Animations.startOpacityAnimation(errorLabel)
            loginButton.layer?.removeAnimationForKey(Animations.ROTATE_KEY)
        }
    }
    
}