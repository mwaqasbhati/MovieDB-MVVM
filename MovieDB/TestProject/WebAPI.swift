//
//  MSNetworkManager.swift
//  MovieSampleSwift
//
//  Created by Muhammad Waqas  on 3/06/18.
//  Copyright (c) 2018 Emaar . All rights reserved.
//

import UIKit
import MBProgressHUD
import Foundation

typealias onCompletion = (Any?, NetworkError?)->()


protocol WebAPIHandler {
    func getDataFromServer(url: String,type: RequestType,completion: @escaping onCompletion)
}

extension WebAPIHandler {
    
    func getDataFromServer(url: String, type: RequestType,completion: @escaping onCompletion) {
        
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, NetworkError.noNetwork)
            return
        }
        Logger.log(message: "URL: \(url)")
        
        let request = RequestType(type: type).getURLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            ParserURLResponse.parseURLResponse(response: response, data: data, completion: completion)
        }
        task.resume()
    }
}

// MARK: - Movie API

struct MovieAPI: WebAPIHandler {
    func getMoviesList(url: String, completion: @escaping onCompletion) {
        getDataFromServer(url: url, type: .MovieList) { (response, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            if let mData = response as? Data {
                let decoder = JSONDecoder()
                let mData = try! decoder.decode(MovieContainer.self, from: mData)
                completion(mData, nil)
            }
        }
    }
}

// MARK: - Movie Detail API

struct MovieDetailAPI: WebAPIHandler {
    func getMovieDetail(url: String, completion: @escaping onCompletion) {
        getDataFromServer(url: url, type: .MovieDetail) { (response, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            if let mData = response as? Data {
                let decoder = JSONDecoder()
                let mData = try? decoder.decode(MovieDetail.self, from: mData)
                if let responseJSON = mData {
                    return completion(responseJSON, nil)
                } else {
                    completion(response, NetworkError.parsingError(Constant.Parsing.message))
                }
                completion(mData, nil)
            }
        }
    }
}

// MARK: - Config API

struct ConfigAPI: WebAPIHandler {
    func getConfigurations(url: String, completion: @escaping onCompletion) {
        getDataFromServer(url: url, type: .Configuration) { (response, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            if let mData = response as? Data {
                let decoder = JSONDecoder()
                let mData = try? decoder.decode(Configuration.self, from: mData)
                if let responseJSON = mData {
                    return completion(responseJSON, nil)
                } else {
                    completion(response, NetworkError.parsingError(Constant.Parsing.message))
                }
            }
        }
    }
}

