//
//  ViewController.swift
//  WomenOfMarvel
//
//  Created by fmustafa on 5/2/22.
//

import Combine
import Kingfisher
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var comicBookCover: UIImageView!

    @IBOutlet weak var comicBookTitle: UILabel!

    @IBOutlet weak var comicBookDescription: UILabel!

    var viewModel = WomenOfMarvelViewModel()

    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
    }

    /// Use the viewModel to fetch the data and publish the event
    private func bindViewModel() {
        self.viewModel.getData()

        viewModel.$comicDetails
           .receive(on: DispatchQueue.main)
           .sink { [weak self] comicDetails in
               // Update the UI when we get the data
               self?.comicBookTitle.text = comicDetails?.data.results[0].title
               self?.comicBookDescription.text = comicDetails?.data.results[0].textObjects[0].text

               // due to insecure URL, added workaround in the Info.plist
               // source: https://stackoverflow.com/questions/32631184/the-resource-could-not-be-loaded-because-the-app-transport-security-policy-requi
               self?.loadImageViaKingfisher(with: comicDetails?.data.results[0].thumbnail.path,
                                            of: comicDetails?.data.results[0].thumbnail.thumbnailExtension)
            }
           .store(in: &cancellables)
    }

    func loadImageViaKingfisher(with urlPath: String?, of type: String?) {

        guard let imageUrlPath = urlPath else {
            print("Nil image url path was given")
            return
        }

        guard let thumbnailExtension = type  else {
            print("Nil thumbnailExtension was given")
            return
        }

        let fullImagePath = imageUrlPath + "." + thumbnailExtension

        let imageUrl = URL(string: fullImagePath)
        print(fullImagePath)
        print(imageUrl)

        // Check if the Comic Book Image is already in the cache. If so, use the cached image
        if ImageCache.default.isCached(forKey: fullImagePath) {
            ImageCache.default.retrieveImage(forKey: fullImagePath) { result in
                switch result {
                case .success(let value):
                    self.comicBookCover.kf.setImage(with: imageUrl)
                    print(value)
                case .failure(let error):
                    print("Failed to load the cached image via Kingfisher. Error:", error)
                }
            }
        } else {
            // The comic book's image is not cached, therefore get and set the image URL onto the image view
            self.comicBookCover.kf.setImage(with: imageUrl, options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ]) { (result) in
                switch result {
                case .success(let image):
                    self.comicBookCover.image = image.image
                case .failure(let error):
                    print("Failed to load the cached image via Kingfisher. Error:", error)
                }
            }
        }
    }

}
