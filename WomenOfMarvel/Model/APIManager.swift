//
//  APIManager.swift
//  WomenOfMarvel
//
//  Created by fmustafa on 5/2/22.
//

import Foundation

struct APIManager {

    static var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .useDefaultKeys
        return jsonDecoder
    }()

    func fetchComicDetails(successHandler: @escaping (WomenOfMarvel) -> Void, errorHandler: @escaping (Error) -> Void) {

        
    }

}
