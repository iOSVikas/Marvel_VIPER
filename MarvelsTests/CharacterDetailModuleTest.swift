//
//  CharacterDetailModuleTest.swift
//  MarvelsTests
//
//  Created by Karambalkar, Vikas - Ext on 04/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import XCTest
@testable import Marvels

class CharacterDetailModuleTest: XCTestCase {

    var sut: CharacterDetailPresenter!
    var character: Character!
    
    //MARK:  XCTestCase lifecycle
    override func setUp() {
        super.setUp()
        
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    //MARK:  Test cases
    
    func testCharacterModel() {
        if let path = Bundle.main.path(forResource: "character", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                if let character = try? decoder.decode(Character.self, from: data) {
                    XCTAssertNotNil(character)
                } else {
                    XCTFail("Unable to parce json")
                }
            } catch {
                XCTFail("Unable to parce json")
            }
        }
        else {
            XCTFail("Moc data file not found")
        }
    }
    
    func testServiceCall() {
        self.loadCharacterFromMocData { (success) in
            if success {
                sut.serviceCall(charID: self.character.characterId!) { (characterData, error) in
                    XCTAssertNotNil(characterData)
                }
            }
            else {
                assertionFailure("Failed to parce data in model, check if changes in Character Class are affecting")
            }
        }
        
    }
}

//MARK: Supporting Funtions
extension CharacterDetailModuleTest {
    func loadCharacterFromMocData(completionHandler: (Bool)->()) {
        if let path = Bundle.main.path(forResource: "character", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                if let character = try? decoder.decode(Character.self.self, from: data) {
                    self.character = character
                    self.sut = CharacterDetailPresenter(character: self.character)
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            } catch {
                completionHandler(false)
            }
        }
        else {
            assertionFailure("Moc data file not found")
        }
    }
}
