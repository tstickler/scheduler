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
    // Base URL of database
    private let baseURL = "https://scheduler-29a0a.firebaseio.com/"
    
    // Retrieve information from the database
    func getRequest(fromPath path: String, _ onComplete: @escaping (Any?, AFError?)->()) {
        AF.request("\(baseURL)\(path).json", method: .get).responseJSON {
            response in
            
            switch response.result {
            case .success(let value) :
                let data = JSON(value)
                onComplete(data, nil)
            case .failure(let error):
                onComplete(nil, error)
            }
        }
    }
    
    // Replace with params to the database
    func putRequest(path: String, params: AnyEncodable, _ onComplete: @escaping (Any?, AFError?)->()) {
        AF.request("\(baseURL)\(path).json",
            method: .put,
            parameters: params,
            encoder: JSONParameterEncoder.default).responseJSON {
                response in

                switch response.result {
                case .success(let value) :
                    let data = JSON(value)
                    onComplete(data, nil)
                case .failure(let error):
                    onComplete(nil, error)
                }
        }
    }
    
    // Add params to the database. Firebase gives a name when doing this.
    func postRequest(path: String, params: AnyEncodable, _ onComplete: @escaping (Any?, AFError?)->()) {
        AF.request("\(baseURL)\(path).json",
            method: .post,
            parameters: params,
            encoder: JSONParameterEncoder.default).responseJSON {
                response in
                
                switch response.result {
                case .success(let value) :
                    let data = JSON(value)
                    onComplete(data, nil)
                case .failure(let error):
                    onComplete(nil, error)
                }
        }
    }
    
    // Update params in database. Can add with own name. Name is the end of path.
    func patchRequest(path: String, params: AnyEncodable, _ onComplete: @escaping (Any?, AFError?)->()) {
        AF.request("\(baseURL)\(path).json",
            method: .patch,
            parameters: params,
            encoder: JSONParameterEncoder.default).responseJSON {
                response in
                
                switch response.result {
                case .success(let value) :
                    let data = JSON(value)
                    onComplete(data, nil)
                case .failure(let error):
                    onComplete(nil, error)
                }
        }
    }
    
    // Remove from database at path.
    func deleteRequest(path: String, _ onComplete: @escaping (Any?, AFError?)->()) {
        AF.request("\(baseURL)\(path).json", method: .delete).responseJSON {
            response in
            
            switch response.result {
            case .success(let value) :
                let data = JSON(value)
                onComplete(data, nil)
            case .failure(let error):
                onComplete(nil, error)
            }
        }
    }
}


// Provides a generic way of encoding all types that will be sent to the database.
struct AnyEncodable: Encodable {
    private let encode: (Encoder) throws -> Void
    public init<T: Encodable>(_ wrapped: T) {
        encode = wrapped.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try encode(encoder)
    }
}
