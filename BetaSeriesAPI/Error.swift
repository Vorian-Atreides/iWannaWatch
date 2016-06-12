//
//  Error.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 5/27/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Foundation

import SwiftyJSON

struct Error: IModel {
    
    static var name: String {
        return "error"
    }
    
    static func isValidJSON(json: JSON) -> Bool {
        return true
    }
    
    enum ErrorType: Int {
        case TokenInvalid = 2001
    }
    
    let code        : Int
    let reason      : String
    
    init(code: Int, reason: String) {
        self.code   = code
        self.reason = reason
    }
    
    init(json: JSON) {
        code        = json["code"].int!
        reason      = json["text"].string!
    }
}