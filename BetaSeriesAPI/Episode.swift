//
//  Episode.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 5/24/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Foundation

import SwiftyJSON

struct Episode: IModel {

    static var name: String {
        return "episode"
    }
    
    static func isValidJSON(json: JSON) -> Bool {
        return true
    }
    
    private static var formatter: NSDateFormatter {
        get {
            let date = NSDateFormatter()
            date.dateFormat = "yyyy-MM-dd"
            return date
        }
    }
    
    struct User {
        
        var seen    : Bool
        
        init(json: JSON) {
            seen    = json["seen"].bool!
        }

    }
    
    struct Show {
        
        let id      : Int
        let title   : String
        
        init(json: JSON) {
            id      = json["id"].int!
            title   = json["title"].string!
        }

    }
    
    struct Note {
        
        let total   : String?
        let mean    : String?
        
        init(json: JSON) {
            total   = json["total"].string
            mean    = json["mean"].string
        }

    }
    
    let id          : Int
    let title       : String
    let season      : Int
    let episode     : Int
    let show        : Show
    let code        : String
    let description : String
    let date        : NSDate?
    let note        : Note
    let user        : User
    let comments    : String
    
    init(json: JSON) {
        id          = json["id"].int!
        title       = json["title"].string!
        season      = json["season"].int!
        episode     = json["episode"].int!
        show        = Show(json: json["show"])
        code        = json["code"].string!
        description = json["description"].string!
        date        = json["date"] != nil ? Episode.formatter.dateFromString(json["date"].string!) : nil
        note        = Note(json: json["note"])
        user        = User(json: json["user"])
        comments    = json["comments"].string!
    }
    
}