//
//  CharacterListInteractor.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation

class CharacterListInteractor: CharacterListInteractorProtocol {
    
    var presenter: CharacterListPresenterProtocol?
    private let apiClient = APIProvider.client

    //MARK: Marvel character list API
    func getCharactersList(limit: Int, offset: Int, completionHandler: @escaping ((_ token: CharactersData?, _ error: Error?)->()) ) {
        if NetworkManager.shared.isNetworkReachable() {
            apiClient.request(.getCharactersList(limit: limit, offset: offset), completion: { (result) in
                do {
                    let characters =  try APIProvider.getAPIResponse(forType: CharactersData.self, result: result)
                    completionHandler(characters,nil)
                } catch _ {
                    completionHandler(nil,MError.apiError("Unable to load records"))
                }
            })
        }
        else {
            completionHandler(nil, MError.networkNotReachable)
        }
    }
}
