//
//  ARequest.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 5/25/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class ARequest {
    
    private static let ACCEPT_HEADER    = "accept"
    private static let KEY_HEADER       = "X-BetaSeries-Key"
    private static let VERSION_HEADER   = "X-BetaSeries-Version"
    private static let TOKEN_HEADER     = "X-BetaSeries-Token"
    private static let ACCEPT_VALUE     = "application/json"
    private static let KEY_VALUE        = "52342e3a453f"
    private static let VERSION_VALUE    = "2.4"
    
    private static let BASE             = "https://api.betaseries.com"
    
    // Compose the base url of the api and the uri specific to the REST requests
    var url: String {
        return "\(ARequest.BASE)/\(uri)"
    }
    // Must be overriden by the inherited classes
    var uri: String {
        return ""
    }
    
    // Build the headers to fit the requirements in BetaSeries
    func buildHeaders() -> [String: String] {
        var headers = [
            ARequest.ACCEPT_HEADER      : ARequest.ACCEPT_VALUE,
            ARequest.KEY_HEADER         : ARequest.KEY_VALUE,
            ARequest.VERSION_HEADER     : ARequest.VERSION_VALUE
        ]
        if let token = UserStorage.token {
            headers[ARequest.TOKEN_HEADER] = token
        }
        return headers
    }
    
    // Convert the JSON into an inflated IModel
    private func builder<T: IModel>(json: JSON, onErrors: ([Error]) -> Void) -> T? {
        if !T.isValidJSON(json) {
            onErrors([Error(code: 1, reason: "JSON is invalid.")])
            return nil
        }
        return T(json: json)
    }
    // Overriden by its array equivalent
    private func builder<T: IModel>(json: JSON, onErrors: ([Error]) -> Void) -> [T] {
        var array = [T]()

        for item in json["\(T.name)s"].arrayValue {
            let data = builder(item, onErrors: onErrors) as T?
            if data == nil {
                return []
            }
            array.append(data!)
        }
        return array
    }
    
    // Execute most of the work, get the data and send the result or the error if something wrong happened.
    func doRequest<T: IModel>(json: JSON, onSuccess: (T) -> Void, onErrors: ([Error]) -> Void) {
        let errors = builder(json, onErrors: onErrors) as [Error]
        if errors.count > 0 {
            onErrors(errors)
            return
        }
        if json.count == 0 {
            onErrors([Error(code: 0, reason: "Service unresponding")])
            return
        }
        
        let data = builder(json[T.name], onErrors: onErrors) as T?
        if data != nil {
            onSuccess(data!)
        }
    }
    // Overriden by its array equivalent
    func doRequest<T: IModel>(json: JSON, onSuccess: ([T]) -> Void, onErrors: ([Error]) -> Void) {
        let errors = builder(json, onErrors: onErrors) as [Error]
        if errors.count > 0 {
            onErrors(errors)
            return
        }
        if json.count == 0 {
            onErrors([Error(code: 0, reason: "Service unresponding")])
            return
        }

        let data = builder(json, onErrors: onErrors) as [T]
        onSuccess(data)
    }
    
}