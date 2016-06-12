//
//  Ping.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 6/2/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Foundation

import Alamofire

class Reachability: ARequest {
    
    // ARequest
    override var uri: String {
        return ""
    }
    
    func Ping(inSuccess: () -> Void, inError: () -> Void) {
        Alamofire.request(.GET, url).response{ request, response, data, error in
            if error == nil {
                inSuccess()
            } else {
                inError()
            }
        }
    }
    
}