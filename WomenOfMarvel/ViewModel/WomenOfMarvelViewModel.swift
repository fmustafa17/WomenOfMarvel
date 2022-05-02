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
}
