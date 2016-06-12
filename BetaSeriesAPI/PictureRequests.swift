//
//  Pictures.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 6/4/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Foundation

import Alamofire

class ShowRequest: ARequest {
    
    // ARequest
    override var uri: String {
        return "pictures/shows"
    }
    
    private func buildParameters(id: Int, height: Int, width: Int) -> [String: String] {
        let i = String(id)
        let h = String(height)
        let w = String(width)
        
        let parameters = [
            "id"        : i,
            "height"    : h,
            "width"     : w
        ]
        return parameters
    }
    
    func getShowWithSize(id: Int, height: Int, width: Int, onSuccess: (NSData) -> Void) {
        let parameters = buildParameters(id, height: height, width: width)
        
        Alamofire.request(.GET, url, parameters: parameters, headers: buildHeaders())
            .responseString { response in
                onSuccess(response.data!)
        }
    }
}