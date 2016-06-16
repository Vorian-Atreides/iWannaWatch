//
//  IReachabilityDelegate.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 6/16/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Foundation

protocol IReachabilityDelegate {
    
    func isUnreachable()
    func isReachable()
    
}