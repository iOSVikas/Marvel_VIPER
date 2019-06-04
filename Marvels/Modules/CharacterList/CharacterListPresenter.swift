//
//  CharacterListPresenter.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation
import UIKit


class CharacterListPresenter: CharacterListPresenterProtocol {

    var interactor: CharacterListInteractor?
    var wireframe: CharacterListWireframe?
    var view: CharacterListViewController?

    private var maxLimit = -1
    private let pageItemLimit: Int = 20
    private var characterList = [Character]()
    
    func viewDidLoad() {
        loadCaractersList()
    }
}


//MARK: API Call And Response Handeling
extension CharacterListPresenter {
    
    func loadCaractersList() {
        if reachedLastIndex() { return }
        if numberOfCharacters() == 0 { self.view?.showLoader(message: "Loading...") } else { self.view?.showFooterLoader() }
        self.serviceCall(limit: pageItemLimit, offset: characterList.count) { (characterData, error) in
            self.view?.hideLoader()
            self.view?.hideFooterLoader()
            if let characterData = characterData {
                self.characterListFetchSuccess(characters: characterData)
            }
            else {
                self.characterListFetchFaild(error: error)
            }
        }
    }
    
    // created method with completion block for Unit testing purpose
    func serviceCall(limit: Int, offset: Int, completionBlock: @escaping(CharactersData?,Error?)->()) {
        self.interactor?.getCharactersList(limit: limit, offset: offset) { (character, error) in
            completionBlock(character, error)
        }
    }
    
    func characterListFetchSuccess(characters: CharactersData) {
        if let results = characters.characters,
            let offset = characters.offset {
            self.maxLimit = characters.total ?? 0
            self.characterList.append(contentsOf: results)
            var reloadIndex = [IndexPath]()
            for index in offset...offset + results.count - 1 {
                reloadIndex.append(IndexPath(row: index, section: 0))
            }
            self.view?.refreshList(indexPathList: reloadIndex)
        }
    }
    
    func characterListFetchFaild(error: Error?) {
        var message = ""
        if let error = error as? MError {
            message = error.localizedDescription
        }
        else if error != nil {
           message = error?.localizedDescription ?? "Unable to load data"
        }
        
        self.view?.hideLoader()
        self.view?.hideFooterLoader()
        self.view?.showAlert(title: "Marvel", message:message)

    }
}

//MARK: View controller datasource methods
extension CharacterListPresenter {
    func numberOfCharacters() -> Int {
        return self.characterList.count
    }
    
    func characterAt(indexPath: IndexPath) -> Character {
        return characterList[indexPath.row]
    }
    
    func reachedLastIndex() -> Bool {
        return maxLimit != -1 && maxLimit <= self.characterList.count
    }
    
    func showCharacterDetail(indexpath: IndexPath, navigationController: UINavigationController) {
        let character = characterAt(indexPath: indexpath)
        self.wireframe?.pushToDetailScreen(character: character, navigationConroller: navigationController)
    }
}
