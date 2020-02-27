//
//  Networking.swift
//  scheduler
//
//  Created by Tyler Stickler on 2/27/20.
//  Copyright © 2020 Tyler Stickler. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Networking {
    let baseURL = "https://scheduler-29a0a.firebaseio.com/"
    
    public func getData(fromPath path: String, _ onComplete: @escaping (Any?, AFError?)->()) {
        getRequest(path: path) {
            response in
            
            switch response.result {
            case .success :
                if let value = response.value {
                    onComplete(JSON(value), nil)
                }
            case .failure:
                onComplete(nil, response.error!)
            }
        }
    }
    
    private func getRequest(path: String, _ onComplete: @escaping (AFDataResponse<Any>)->()) {
        AF.request("\(baseURL)\(path).json").responseJSON {
            response in
            
            onComplete(response)
        }
    }
}


