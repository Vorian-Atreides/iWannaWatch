//
//  Animations.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 6/12/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Cocoa

class Animations {

    static let OPACITY_KEY  = "opacity"
    static let SHAKING_KEY  = "shaking"
    static let SCALE_KEY    = "scale"
    static let ROTATE_KEY   = "rotate"

    
    static func startOpacityAnimation(view: NSView) {
        
        let animation               = CABasicAnimation.init(keyPath: "opacity")
        
        animation.fromValue         = 0
        animation.toValue           = 1
        animation.duration          = 2
        animation.timingFunction    = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.autoreverses      = true
        
        view.layer!.addAnimation(animation, forKey: Animations.OPACITY_KEY)
        
    }
    
    static func startShakeAnimation(view: NSView) {
        let animation           = CABasicAnimation(keyPath: "position")
        
        animation.duration      = 0.05
        animation.repeatCount   = 2
        animation.autoreverses  = true
        
        animation.fromValue     = NSValue(point: CGPointMake(view.frame.origin.x - 5, view.frame.origin.y))
        animation.fromValue     = NSValue(point: CGPointMake(view.frame.origin.x + 5, view.frame.origin.y))
        
        view.layer?.addAnimation(animation, forKey: Animations.SHAKING_KEY)
    }
    
    static func startScaleAnimation(view: NSView) {
        let animation               = CABasicAnimation(keyPath: "transform.scale")
        
        animation.fromValue         = 1
        animation.toValue           = 1.25
        animation.duration          = 0.25
        animation.timingFunction    = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.autoreverses      = true
        
        let oldFrame = view.layer?.frame.origin
        view.layer?.anchorPoint = CGPointMake(0.5, 0.5)
        view.layer?.frame.origin = oldFrame!
        view.layer?.addAnimation(animation, forKey: Animations.SCALE_KEY)
    }
    
    static func startSpinningAnimation(view: NSView) {
        let spinning                = CABasicAnimation(keyPath: "transform.rotation.z")
        
        spinning.byValue           = -2 * M_PI
        spinning.duration          = 1.5
        spinning.repeatCount       = Float.infinity
        
        view.layer?.addAnimation(spinning, forKey: Animations.ROTATE_KEY)
    }
}