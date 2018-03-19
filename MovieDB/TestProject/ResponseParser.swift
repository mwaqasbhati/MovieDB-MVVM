//
//  CountryParser.swift
//  TDMall
//
//  Created by Muhammad Waqas on 3/06/18.
//  Copyright © 2018 Emaar Corp. All rights reserved.
//

import Foundation

class MyError: Codable {
    var status_message: String
    var status_code: Int
    
    private enum CodingKeys: String, CodingKey {
        case status_code = "status_code"
        case status_message = "status_message"
    }
}

struct ParserURLResponse {
    
    static func parseURLResponse(response: URLResponse?, data: Data?, completion: onCompletion) {
        if let httpResponse = response as? HTTPURLResponse {
            
            let code = httpResponse.statusCode
            
            Logger.log(message: "statusCode: \(code)")
            Logger.log(message: "Response: \(String(describing: String(data: data!, encoding: .utf8)))")
            
            if code == 200 {
                completion(data, nil)
            }
            else if code == 401 || code == 404 {
                let decoder = JSONDecoder()
                let mData = try? decoder.decode(MyError.self, from: data ?? Data())
                if let responseJSON = mData {
                    return completion(response, NetworkError.unknown(responseJSON.status_message))
                } else {
                    completion(nil, NetworkError.parsingError(Constant.Parsing.message))
                }
            } else {
                completion(nil, NetworkError.unknown(Constant.Parsing.unKnown))
            }
        }
    }
}
