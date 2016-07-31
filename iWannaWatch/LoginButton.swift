//
//  LoginButton.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 7/31/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Cocoa

@IBDesignable
class LoginButton: NSButton {
    
    @IBInspectable
    var normalColor: NSColor = NSColor.greenColor() {
        didSet {
            
        }
    }
    
    @IBInspectable
    var errorColor: NSColor = NSColor.redColor() {
        didSet {
            
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
}