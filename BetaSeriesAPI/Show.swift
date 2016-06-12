//
//  Show.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 6/1/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Foundation

import SwiftyJSON

struct Show: IModel {
    
    static var name: String {
        return "show"
    }
    
    static func isValidJSON(json: JSON) -> Bool {
        return true
    }
    
    let id          : Int
    let title       : String
    let remaining   : Int
    var unseen      = [Episode]()
    
    init(json: JSON) {
        id          = json["id"].int!
        title       = json["title"].string!
        remaining   = json["remaining"].int!
        for item in json["unseen"].arrayValue {
            let episode = Episode(json: item)
            unseen.append(episode)
        }
    }
}