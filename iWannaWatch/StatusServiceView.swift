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

    @IBOutlet weak var StatusImage: NSImageView!
    
    private static let green    = NSImage(named: "greenStatus")
    private static let red      = NSImage(named: "redStatus")
    
    private let reachability    = Reachability()
    
    override func awakeFromNib() {
        let timer = NSTimer(timeInterval: 01 * 60, target: self, selector:
            #selector(StatusServiceView.updateStatus),
                            userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        updateStatus()
    }
    
    @objc
    private func updateStatus() {
        reachability.Ping(inPingSuccess, inError: inPingError)
    }
    
    private func inPingSuccess() {
        self.StatusImage.image  = StatusServiceView.green
    }
    
    private func inPingError() {
        self.StatusImage.image  = StatusServiceView.red
    }
    
}
