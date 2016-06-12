//
//  NSUrlExtend.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 5/26/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Foundation

extension String {
    
    func findGetParameter(name: String) -> String? {
        let str = self as NSString
        let pattern = "\(name)=\\w+"
        
        let regex = try! NSRegularExpression(pattern: pattern, options: [])

        let matches = regex.matchesInString(self, options: [], range: NSMakeRange(0, str.length))
        if matches.count != 1 {
            return nil
        }
        let tmp = str.substringWithRange(matches[0].range)
        return tmp.stringByReplacingOccurrencesOfString("\(name)=", withString: "")
    }
    
}