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
        jsonDecoder.keyDecodingStrategy = .useDefaultKeys
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

    /// Adds the required query parameters to the GET request for the Marvel API
    /// - Parameter offset: The requested offset (number of skipped results) of the call
    /// - Returns: a dictionary wiht key/value pairs that need to be set into URLQueryItems
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

    func fetchComicDetails(successHandler: @escaping (WomenOfMarvel) -> Void,
                           errorHandler: @escaping (Error) -> Void) {

        let baseURL = "https://gateway.marvel.com/"

        let comicID =  "1590"

        let path = "v1/public/comics/\(comicID)"

        let fullRequestURL = baseURL + path

        var components = URLComponents(string: fullRequestURL)!

        let params = setParameters(offset: 0)

        // Set the query
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
                    successHandler(details)
                }
            } catch {
                print("Response:", response!)
                print(error)
            }
        }

        task.resume()
    }

}
