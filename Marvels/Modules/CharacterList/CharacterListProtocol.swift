//
//  CharacterListProtocol.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation
import UIKit

protocol CharacterListViewProtocol: class{
    func setupTableView()
    func reloadTableView()
    func showLoader(message: String?)
    func hideLoader()
    func showFooterLoader()
    func hideFooterLoader()
    func setRefreshButton()
    func removeRefreshButton()
    func showAlert(title: String, message: String)
}

protocol CharacterListPresenterProtocol: class {
    func viewDidLoad()
    func loadCaractersList()
    func characterListFetchSuccess(characters: CharactersData)
    func characterListFetchFaild(error: Error?)
    func numberOfCharacters() -> Int
    func characterAt(indexPath: IndexPath) -> Character
    func reachedLastIndex() -> Bool
    func showCharacterDetail(indexpath: IndexPath, navigationController: UINavigationController)
}

protocol CharacterListWireframeProtocol: class {
    static func createModule()-> CharacterListViewController
    func pushToDetailScreen(character: Character, navigationConroller navigationController:UINavigationController)
}

protocol CharacterListInteractorProtocol: class {
    func getCharactersList(limit: Int, offset: Int, completionHandler: @escaping ((_ token: CharactersData?, _ error: Error?)->()) )
    
}

