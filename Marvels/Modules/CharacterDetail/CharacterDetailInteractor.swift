//
//  CharacterDetailInteractor.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation

class CharacterDetailInteractor: CharacterDetailInteractorProtocol {
    
    var presenter: CharacterDetailPresenterProtocol?
    private let apiClient = APIProvider.client
    
    //MARK: Marvel character details API
    func getCharactersDetails(charID: Int, completionHandler: @escaping ((_ token: CharactersData?, _ error: Error?)->()) ) {
        if NetworkManager.shared.isNetworkReachable() {
            let charIDStr = "\(charID)"
            apiClient.request(.getCharactersDetail(charcterID: charIDStr), completion: { (result) in
                do {
                    let resultObj =  try APIProvider.getAPIResponse(forType: CharactersData.self, result: result)
                    completionHandler(resultObj,nil)
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
