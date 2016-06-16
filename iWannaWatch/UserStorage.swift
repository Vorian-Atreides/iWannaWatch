//
//  UserStorage.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 6/4/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Foundation

import SwiftyJSON

class UserStorage {
    
    static private let USER_KEY     = "user"
    static private let TOKEN_KEY    = "token"
    static private let PICTURES_KEY = "pictures"
    
    static private let _userDefault  = NSUserDefaults.standardUserDefaults()
    
    static var user: User? {
        get {
            if let data = _userDefault.objectForKey(UserStorage.USER_KEY) as? NSData {
                return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? User
            }
            return nil
        }
        set {
            if let value = newValue {
                let data = NSKeyedArchiver.archivedDataWithRootObject(value)
                _userDefault.setObject(data, forKey: UserStorage.USER_KEY)
            } else {
                _userDefault.removeObjectForKey(UserStorage.USER_KEY)
            }
        }
    }
    
    static var token: String? {
        get {
            return _userDefault.stringForKey(UserStorage.TOKEN_KEY)
        }
        set {
            if let value = newValue {
                _userDefault.setObject(value as AnyObject, forKey: UserStorage.TOKEN_KEY)
            } else {
                _userDefault.removeObjectForKey(UserStorage.TOKEN_KEY)
            }
        }
    }
    
    static func savePicture(key: String, image: NSImage) {
        let cg = image.CGImageForProposedRect(nil, context: nil, hints: nil)!
        let bmp = NSBitmapImageRep(CGImage: cg)
        let png = bmp.representationUsingType(NSBitmapImageFileType.NSPNGFileType, properties: [:])
        _userDefault.setValue(png, forKeyPath: key)
    }
    
    static func getPicture(key: String) -> NSImage? {
        if let data = _userDefault.objectForKey(key) as? NSData {
            return NSImage(data: data)
        }
        return nil
    }
    
    static func clear() {
        _userDefault.removePersistentDomainForName(NSBundle.mainBundle().bundleIdentifier!)
    }
    
    static func picturesClear() {
        let token = UserStorage.token
        let user = UserStorage.user
        
        UserStorage.clear()
        UserStorage.token = token
        UserStorage.user = user
    }
}