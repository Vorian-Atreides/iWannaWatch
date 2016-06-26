//
//  StatusService.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 6/1/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Cocoa

import Alamofire

class StatusServiceView: NSView {

    @IBOutlet weak var statusImage  : NSImageView!
    
    private static let green        = NSImage(named: "greenStatus")
    private static let red          = NSImage(named: "redStatus")

    enum Reachability {
        case Reachable;
        case UnReachable;
    }
    
    private var state   = Reachability.UnReachable
    var State           : Reachability {
        get {
            return state
        }
        set {
            state = newValue
            switch state {
            case Reachability.Reachable     : statusImage?.image = StatusServiceView.green
            case Reachability.UnReachable   : statusImage?.image = StatusServiceView.red
            }
        }
    }
    
    override func awakeFromNib() {
    }
    
}
