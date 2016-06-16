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

    @IBOutlet weak var StatusImage  : NSImageView!
    
    private static let green        = NSImage(named: "greenStatus")
    private static let red          = NSImage(named: "redStatus")

    override func awakeFromNib() {
        isUnreachable()
    }
    
    func isReachable() {
        self.StatusImage.image  = StatusServiceView.green
    }
    
    func isUnreachable() {
        self.StatusImage.image  = StatusServiceView.red
    }
    
}
