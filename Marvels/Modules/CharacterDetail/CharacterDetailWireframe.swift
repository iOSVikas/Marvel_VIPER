//
//  CharacterDetailWireframe.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation
import UIKit

class CharacterDetailWireframe: CharacterDetailWireframeProtocol{

    static func createModule(character: Character) -> CharacterDetailViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
        
        let presenter: CharacterDetailPresenter = CharacterDetailPresenter(character: character)
        let interactor: CharacterDetailInteractor = CharacterDetailInteractor()
        let wireframe: CharacterDetailWireframe = CharacterDetailWireframe()
        
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
}
