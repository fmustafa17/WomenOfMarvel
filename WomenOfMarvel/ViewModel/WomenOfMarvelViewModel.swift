//
//  WomenOfMarvelViewModel.swift
//  WomenOfMarvel
//
//  Created by fmustafa on 5/2/22.
//

import Foundation
import Combine

class WomenOfMarvelViewModel: ObservableObject {
    private var apiManager: APIManager?
    @Published var comicDetails: WomenOfMarvel!

    init() {
        self.apiManager = APIManager()
    }

    func getData() {
        apiManager?.fetchComicDetails(successHandler: { [weak self] (details) in
            self?.comicDetails = details
        }) { (error) in
            print("Error occurred: ", error)
        }
    }

    func getFullImageURLString(with urlPath: String?, of type: String?) -> String {
        guard let imageUrlPath = urlPath else {
            print("Nil image url path was given")
            return ""
        }

        guard let thumbnailExtension = type  else {
            print("Nil thumbnailExtension was given")
            return ""
        }

        let fullImagePath = imageUrlPath + "." + thumbnailExtension
        return fullImagePath
    }
}
