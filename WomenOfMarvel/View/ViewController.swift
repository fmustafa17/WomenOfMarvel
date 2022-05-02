//
//  ViewController.swift
//  WomenOfMarvel
//
//  Created by fmustafa on 5/2/22.
//

import UIKit
import Combine

class ViewController: UIViewController {

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
           .sink { comicDetails in
              print(1)
           }
           .store(in: &cancellables)
    }


}

