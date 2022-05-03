//
//  ViewController.swift
//  WomenOfMarvel
//
//  Created by fmustafa on 5/2/22.
//

import UIKit
import Combine

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
               self?.comicBookDescription.text =  comicDetails?.data.results[0].textObjects[0].text
           }
           .store(in: &cancellables)
    }

}
