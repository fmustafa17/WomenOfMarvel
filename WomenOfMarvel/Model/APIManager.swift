//
//  APIManager.swift
//  WomenOfMarvel
//
//  Created by fmustafa on 5/2/22.
//

import Foundation
import CommonCrypto
import SwiftKeychainWrapper

struct APIManager {

    static var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        //        jsonDecoder.keyDecodingStrategy = .useDefaultKeys
        return jsonDecoder
    }()

    func getTimestamp() -> String {
        return String(Int(Date().timeIntervalSince1970))
    }

    func getMd5(ts: String) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH) // CommonCrypto
        let privateKey = KeychainWrapper.standard.string(forKey: Constants.myPrivateKey) ?? ""
        let publicKey = KeychainWrapper.standard.string(forKey: Constants.myPublicKey) ?? ""
        let concatenatedString = ts + privateKey + publicKey
        let messageData = concatenatedString.data(using: .utf8)!
        var digestData = Data(count: length)
        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }

        let md5Hex =  digestData.map { String(format: "%02hhx", $0) }.joined()
        return String(md5Hex)
    }

    func setParameters(offset: Int) -> [String: Any] {

        let timeStamp = String(getTimestamp())
        let md5hash = getMd5(ts: timeStamp)
        let params: [String: Any] = [
            Constants.apiKey: KeychainWrapper.standard.string(forKey: Constants.myPublicKey) ?? "",
            Constants.timeStampKey: timeStamp,
            Constants.hashKey: md5hash,
            Constants.offsetKey: String(offset)
        ]
        return params
    }

    /*
    func sendRequest(_ url: String, parameters: [String: Any], completion: @escaping (WomenOfMarvel?, Error?) -> Void) {
        var components = URLComponents(string: url)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value as! String)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,                              // is there data
                let response = response as? HTTPURLResponse,  // is there HTTP response
                200 ..< 300 ~= response.statusCode,           // is statusCode 2XX
                error == nil                                  // was there no error
            else {
                completion(nil, error)
                return
            }

            let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
            completion(responseObject, nil)
        }
        task.resume()
    }
     */

    func fetchComicDetails(successHandler: @escaping (WomenOfMarvel) -> Void,
                           errorHandler: @escaping (Error) -> Void) {

        let baseURL = "https://gateway.marvel.com/"

        let comicID =  "1590"

        let path = "v1/public/comics/\(comicID)"

        //        let fullRequestURL = baseURL + path + "?apikey=" + apiKey
        let fullRequestURL = "https://gateway.marvel.com/v1/public/comics/1590"

        var components = URLComponents(string: fullRequestURL)!

        let params = setParameters(offset: 0)

        components.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value as! String)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard error == nil else {
                print("error, ", error ?? "Error occurred")
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    errorHandler(NSError(domain: "", code: 0, userInfo: nil))
                }
                return
            }

            do {
                let details = try APIManager.jsonDecoder.decode(WomenOfMarvel.self, from: data)

                DispatchQueue.main.async {
                    print(details)
                    successHandler(details)
                }
            } catch {
                print("Response:", response!)
                print(error)
            }
        }

        task.resume()

        /*

        sendRequest(fullRequestURL, parameters: setParameters(offset: 0)) { responseObject, error in
            guard error == nil else {
                print("error, ", error ?? "Error occurred")
                return
            }

            guard let response = responseObject else {
                print(error ?? "Unknown error")
                return
            }

            do {
                let details = try APIManager.jsonDecoder.decode(WomenOfMarvel.self, from: response)

                DispatchQueue.main.async {
                    print(details)
                    successHandler(details)
                }
            } catch {
                print("Response:", response)
                print(error)
            }

        }

         */


        /*
        let urlRequest = URLRequest(url: URL(string: fullRequestURL)!)

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("error, ", error ?? "Error occurred")
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    errorHandler(NSError(domain: "", code: 0, userInfo: nil))
                }
                return
            }

            do {
                let details = try APIManager.jsonDecoder.decode(WomenOfMarvel.self, from: data)

                DispatchQueue.main.async {
                    print(details)
                    successHandler(details)
                }
            } catch {
                print("Response:", response!)
                print(error)
            }
        }
        task.resume()
         */
    }


}
