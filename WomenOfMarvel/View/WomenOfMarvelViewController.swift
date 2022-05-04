//
//  ViewController.swift
//  WomenOfMarvel
//
//  Created by fmustafa on 5/2/22.
//

import Combine
import Kingfisher
import UIKit

class WomenOfMarvelViewController: UIViewController {

    @IBOutlet weak var comicBookCover: UIImageView!

    @IBOutlet weak var comicBookTitle: UILabel!

    @IBOutlet weak var comicBookDescription: UILabel!

    var viewModel = WomenOfMarvelViewModel()

    var fullImagePath: String! = ""

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
               self?.fullImagePath = self?.viewModel.getFullImageURLString(with: comicDetails?.data.results[0].thumbnail.path,
                                                                           of: comicDetails?.data.results[0].thumbnail.thumbnailExtension)

               self?.loadImageViaKingfisher(with: (self?.fullImagePath)!)
            }
           .store(in: &cancellables)
    }

    func loadImageViaKingfisher(with urlString: String) {

        guard let imagePath = fullImagePath, !imagePath.isEmpty else {
            print("Nil or empty fullImagePath was passed. Value:", fullImagePath!)
            return
        }

        let imageUrl = URL(string: urlString)

        // Check if the Comic Book Image is already in the cache. If so, use the cached image
        if ImageCache.default.isCached(forKey: imagePath) {
            ImageCache.default.retrieveImage(forKey: imagePath) { result in
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
