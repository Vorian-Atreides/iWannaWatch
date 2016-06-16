//
//  Authentication.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 5/25/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Foundation

import Alamofire
import CryptoSwift
import SwiftyJSON

//
// TODO Should do an OAuth2 when the protocol will be respected in the server side.
//
class Authentication: ARequest {
    
    // ARequest
    override var uri: String {
        return "members/auth"
    }
    
    func buildParameters(login: String, password: String) -> [String: String] {
        let parameters = [
            "login"     : login,
            "password"  : password
        ]
        return parameters
    }
    
    func authenticate(login: String, password: String, onSuccess: (User) -> Void, onErrors: ([Error]) -> Void) {
        let parameters = buildParameters(login, password: password)
        
        Alamofire.request(.POST, url, parameters: parameters, headers: buildHeaders())
            .responseData{ response in
                let json = JSON(data: response.data!)
                UserStorage.token = json["token"].string
                self.doRequest(json, onSuccess: onSuccess, onErrors: onErrors)
        }
    }
    
}