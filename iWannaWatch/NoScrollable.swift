//
//  NoScrollable.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 6/23/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Cocoa

class NoScrollable: NSScrollView {

    override func awakeFromNib() {
        self.hasVerticalScroller    = false
        self.hasVerticalScroller    = false
    }
    
    override func scrollWheel(theEvent: NSEvent) {
        self.superview?.scrollWheel(theEvent)
    }
        
}
