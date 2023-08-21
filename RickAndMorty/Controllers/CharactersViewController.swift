//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Sergey Kykhov on 17.08.2023.
//

import UIKit
import Foundation
import SwiftUI

class CharactersViewController: UIViewController {

    private var characters: [CharactersModelElement] = []

    //MARK: - Properties
    private lazy var collection: UICollectionView = {
        let layout = createLayoutCollection()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 0.013, green: 0.048, blue: 0.119, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionsCharacterCell.self, forCellWithReuseIdentifier: CollectionsCharacterCell.identifier)
        return collectionView
    }()

    private lazy var loader: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .green
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    //MARK: - Methods
    private func settingsNavigation() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Characters"

        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 27, weight: .bold),
            .foregroundColor: UIColor.white
        ]

        navigationController?.navigationBar.largeTitleTextAttributes = titleAttributes
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
    }

    private func navigationSwiftUiInUikit(character: CharactersModelElement) {
        let detailScreenInfoController = DetailScreenInfo(character: character)
        let hostingController = UIHostingController(rootView: detailScreenInfoController)
        navigationController?.pushViewController(hostingController, animated: true)
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collection)
        view.addSubview(loader)
        settingsNavigation()
        setupLayout()

        loader.startAnimating()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { //проверка loader, задержка подгрузки данных на 1 сек.)
            NetworkManager.shared.makeRequst(url: Constants.url, params: Constants.params) { characters in
                DispatchQueue.main.async {
                    self.loader.stopAnimating()
                    self.characters = characters
                    self.collection.reloadData()
                    for character in characters {
                        print("Character name: \(character.name)")
                        print("Character name: \(character.image)")
                    }
                }
            }
        }
    }

    //MARK: - Layout
    private func setupLayout() {
        collection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
                loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }

    private func createLayoutCollection() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in

            //Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.75))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

            //Group
            let groupSize = NSCollectionLayoutSize( widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
            let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [layoutItem])

            //Section
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 10, bottom: 10, trailing: 10)
            return layoutSection
        }
    }
} // finish class

//MARK: - Extension
extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: CollectionsCharacterCell.identifier, for: indexPath) as! CollectionsCharacterCell
        cell.backgroundColor = UIColor(red: 0.149, green: 0.165, blue: 0.22, alpha: 1)
        cell.layer.cornerRadius = 15

        let character = characters[indexPath.item]
        cell.nameLabel.text = character.name
        if let imageURL = URL(string: character.image) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        cell.image.image = UIImage(data: imageData)
                    }
                }
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationSwiftUiInUikit(character: characters[indexPath.row])
    }
}
