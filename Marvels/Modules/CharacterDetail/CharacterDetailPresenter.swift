//
//  CharacterDetailPresenter.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation


class CharacterDetailPresenter: CharacterDetailPresenterProtocol {
    
    var interactor: CharacterDetailInteractor?
    var wireframe: CharacterDetailWireframe?
    var view: CharacterDetailViewController?
    
    var character: Character?
    
    init(character: Character) {
        self.character = character
    }
    
    func viewDidLoad() {
        self.loadCaracterDetails()
    }
}

//MARK: API Interactor
extension CharacterDetailPresenter {
    func loadCaracterDetails() {
        guard let charId = self.character?.characterId else {
            return
        }
        self.view?.showLoader(message: "Loading...")
        self.serviceCall(charID: charId) { (characterData, error) in
            self.view?.hideLoader()
            if let characterData = characterData {
                self.characterDetailFetchSuccess(character: characterData)
            }
            else {
                self.characterDetailFetchFailed(error: error)
            }
        }
    }
    
    // created method with completion block for Unit testing purpose
    func serviceCall(charID: Int, completionBlock: @escaping(CharactersData?,Error?)->()) {
        self.interactor?.getCharactersDetails(charID: charID) { (character, error) in
            completionBlock(character, error)
        }
    }
    
    func characterDetailFetchSuccess(character: CharactersData) {
        if character.characters?.count ?? 0 > 0 {
            self.character = character.characters?[0]
            self.view?.setDisplayFrom(character: self.character!)
        }
    }
    
    func characterDetailFetchFailed(error: Error?) {
        if let error = error as? MError {
            self.character = nil
            self.view?.clearDisplayValues(message: error.localizedDescription)
        }
        else if error != nil {
            self.character = nil
            self.view?.clearDisplayValues(message: error?.localizedDescription ?? "Unable to load data")
        }
    }
    
}

//MARK: View controller datasource methods
extension CharacterDetailPresenter {
    func numberOfSections() -> Int {
        return self.character != nil ? 3 : 0
    }
    
    func numberOfRowsAt(section: Int) -> Int {
        switch section {
        case 0:
            return self.character?.comics?.items?.count ?? 0
        case 1:
            return self.character?.series?.items?.count ?? 0
        case 2:
            return self.character?.stories?.items?.count ?? 0
        default:
            return 0
        }
    }
    
    func titleFor(section: Int) -> String {
        switch section {
        case 0:
            return "COMICS"
        case 1:
            return "SERIES"
        case 2:
            return "STORIES"
        default:
            return ""
        }
    }
    
    func characterAt(indexPath: IndexPath) -> Item? {
        
        switch indexPath.section {
        case 0:
            let item = self.character?.comics?.items?[indexPath.row]
            return item
        case 1:
            let item = self.character?.series?.items?[indexPath.row]
            return item
        case 2:
            let item = self.character?.stories?.items?[indexPath.row]
            return item
        default:
            return nil
        }
    }
}

