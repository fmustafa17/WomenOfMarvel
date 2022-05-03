//
//  ComicBookView.swift
//  WomenOfMarvel
//
//  Created by fmustafa on 5/2/22.
//

import UIKit

class ComicBookView: UIView {
    var comicBookCover: UIImageView = {
        let imageView = UIImageView()
        imageView.accessibilityIdentifier = "comicBookCover"
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

//    var comicBookTextStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.backgroundColor = .clear
//        stackView.spacing = 16
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()

    var comicBookTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.accessibilityIdentifier = "comicBookTitle"
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lorem Ipsum"
        return label
    }()

    var comicBookDescriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.accessibilityIdentifier = "comicBookDescription"
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lorem Ipsum"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
//        setUpInitialUI()
        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    private lazy var comicBookView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.accessibilityIdentifier = "comicBookView"
//        return view
//    }()

    var comicBookTitleText: String? {
        didSet {
            updateLabel()
        }
    }

    func updateLabel() {
        comicBookTitleLabel.text = comicBookTitleText
    }

    func setUpUI() {
//        self.addSubview(comicBookTextStackView)
//        comicBookTextStackView.backgroundColor =  .red
//
//        comicBookTextStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        comicBookTextStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        comicBookTextStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        comicBookTextStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//
//        comicBookTextStackView.addArrangedSubview(comicBookTitleLabel)

        self.addSubview(comicBookTitleLabel)

        comicBookTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        comicBookTitleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        comicBookTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        comicBookTitleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        comicBookTitleLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true

    }

    /*
    func setUpInitialUI() {
//        self.addSubview(comicBookCover)
        self.addSubview(comicBookTextStackView)
//        self.addSubview(comicBookTitleLabel)
//        self.addSubview(comicBookDescriptionLabel)

        // Add constraints for the image
//        comicBookCover.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
//        comicBookCover.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
//        comicBookCover.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
//        comicBookCover.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 15).isActive = true

        comicBookTextStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        comicBookTextStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        comicBookTextStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        comicBookTextStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        comicBookTextStackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        comicBookTextStackView.isLayoutMarginsRelativeArrangement = true

        comicBookTextStackView.addArrangedSubview(comicBookTitleLabel)
        comicBookTextStackView.addArrangedSubview(comicBookDescriptionLabel)




//        comicBookTitleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
//        comicBookTitleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
//        comicBookTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
//        comicBookTitleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        comicBookTitleLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
//        comicBookTitleLabel.topAnchor.constraint(equalTo: self.comicBookCover.bottomAnchor, constant: 10).isActive = true
//        comicBookTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 15).isActive = true

//        comicBookDescriptionLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
//        comicBookDescriptionLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 50).isActive = true
//        comicBookDescriptionLabel.topAnchor.constraint(equalTo: self.comicBookTitleLabel.bottomAnchor, constant: 10).isActive = true
//        comicBookDescriptionLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 15).isActive = true

    }
    */

}
