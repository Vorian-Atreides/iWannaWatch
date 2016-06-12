//
//  FavoritesShowRequests.swift
//  iWannaWatch
//
//  Created by Gaston Siffert on 6/1/16.
//  Copyright © 2016 Gaston Siffert. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class EpisodesRequest: ARequest {
    
    // ARequest
    override var uri: String {
        return "episodes/list"
    }
    
    private static let LIMIT    = "5"

    
    //
    // Get
    //
    
    private func getParameters() -> [String: String] {
        let parameters = [
            "limit"             : EpisodesRequest.LIMIT,
        ]
        
        return parameters
    }
    
    // Request
    func get(onSuccess: ([Show]) -> Void, onErrors: ([Error]) -> Void) {
        Alamofire.request(.GET, url, parameters: getParameters(), headers: buildHeaders())
            .responseData{ response in
                let json = JSON(data: response.data!)
                self.doRequest(json, onSuccess: onSuccess, onErrors: onErrors)
        }
    }
}

class EpisodeWatchedRequest: ARequest {
    
    // ARequest
    override var uri: String {
        return "episodes/watched"
    }
    
    private func parameters(id: String) -> [String: String] {
        let parameters = [
            "id"             : id,
            ]
        
        return parameters
    }
    
    // Post
    func post(id: Int, onSuccess: (Episode) -> Void, onErrors: ([Error]) -> Void) {
        Alamofire.request(.POST, url, parameters: parameters(String(id)), headers: buildHeaders())
            .responseData{ response in
                let json = JSON(data: response.data!)
                self.doRequest(json, onSuccess: onSuccess, onErrors: onErrors)
        }
    }
    
    // Delete
    func delete(id: Int, onSuccess: (Episode) -> Void, onErrors: ([Error]) -> Void) {
        Alamofire.request(.DELETE, url, parameters: parameters(String(id)), headers: buildHeaders())
            .responseData{ response in
                let json = JSON(data: response.data!)
                self.doRequest(json, onSuccess: onSuccess, onErrors: onErrors)
        }
    }
}