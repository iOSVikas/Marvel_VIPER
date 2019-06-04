//
//  CharacterDetailProtocol.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation
import UIKit

protocol CharacterDetailViewProtocol: class{
    func updateHeaderFrame()
    func setupCollectionView()
    func showLoader(message: String?)
    func hideLoader()
    func setbackButton()
    func showAlert(title: String, message: String)
    func setDisplayFrom(character: Character)
    func clearDisplayValues(message: String)
}

protocol CharacterDetailPresenterProtocol: class {
    func viewDidLoad()
    func loadCaracterDetails()
    func characterDetailFetchSuccess(character: CharactersData)
    func characterDetailFetchFailed(error: Error?)
    func numberOfSections() -> Int
    func numberOfRowsAt(section: Int) -> Int
    func titleFor(section: Int) -> String
    func characterAt(indexPath: IndexPath) -> Item?
}

protocol CharacterDetailWireframeProtocol: class {
    static func createModule(character: Character) -> CharacterDetailViewController
}

protocol CharacterDetailInteractorProtocol: class {
    func getCharactersDetails(charID: Int, completionHandler: @escaping ((_ token: CharactersData?, _ error: Error?)->()) )
}
