//
//  IModel.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 5/28/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Foundation

import SwiftyJSON

protocol IModel {
    
    static var name: String {
        get
    }
    
    static func isValidJSON(json: JSON) -> Bool
    
    init(json: JSON)    
}