//
//  CharacterListWireframe.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation
import UIKit

class CharacterListWireframe: CharacterListWireframeProtocol{

    static func createModule() -> CharacterListViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "CharacterListViewController") as! CharacterListViewController
        
        let presenter: CharacterListPresenter = CharacterListPresenter()
        let interactor: CharacterListInteractor = CharacterListInteractor()
        let wireframe: CharacterListWireframe = CharacterListWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireframe = wireframe
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToDetailScreen(character: Character, navigationConroller navigationController:UINavigationController) {
        let detailModule = CharacterDetailWireframe.createModule(character: character)
        navigationController.pushViewController(detailModule,animated: true)
    }
}
