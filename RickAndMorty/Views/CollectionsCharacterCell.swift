//
//  CollectionsCharacterCell.swift
//  RickAndMorty
//
//  Created by Sergey Kykhov on 17.08.2023.
//

import Foundation
import UIKit

class CollectionsCharacterCell: UICollectionViewCell {

    static let identifier = "cell"

    //MARK: - Properties
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .darkGray
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

        private let stack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .center
            stack.distribution = .fill
            return stack
        }()

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Hierarchy
        private func setupHierarchy() {
            addSubview(stack)
            stack.addArrangedSubview(image)
            stack.addArrangedSubview(nameLabel)
        }

        //MARK: - Layout
        private func setupLayout() {
            image.translatesAutoresizingMaskIntoConstraints = false
            image.widthAnchor.constraint(equalToConstant: 140).isActive = true
            image.heightAnchor.constraint(equalToConstant: 140).isActive = true
            image.topAnchor.constraint(equalTo: topAnchor,constant: 8).isActive = true
            image.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8).isActive = true
            image.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8).isActive = true
            image.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -54).isActive = true

            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.topAnchor.constraint(equalTo: topAnchor,constant: 5).isActive = true
            stack.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5).isActive = true
            stack.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -5).isActive = true
            stack.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -5).isActive = true
        }
    }
