//
//  User.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 5/27/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Foundation

import SwiftyJSON

@objc(User)
class User: NSObject, NSCoding, IModel {
    
    private static let  ID_KEY          = "id"
    private static let  LOGIN_KEY       = "login"
    private static let  PASSWORD_KEY    = "password"
    
    static var name: String {
        return "user"
    }
    
    static func isValidJSON(json: JSON) -> Bool {
        return true
    }
    
    let id          : Int?
    let login       : String?
    var password    : String?
    
    required init(json: JSON) {
        id          = json["id"].int
        login       = json["login"].string
        password    = ""
    }
    
    @objc
    required init?(coder aDecoder: NSCoder) {
        id          = aDecoder.decodeIntegerForKey(User.ID_KEY)
        login       = aDecoder.decodeObjectForKey(User.LOGIN_KEY) as? String
        password    = aDecoder.decodeObjectForKey(User.PASSWORD_KEY) as? String
    }
    
    @objc
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(id!, forKey: User.ID_KEY)
        coder.encodeObject(login!, forKey: User.LOGIN_KEY)
        coder.encodeObject(password!, forKey: User.PASSWORD_KEY)
    }
}