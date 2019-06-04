//
//  CharacterListModuleTest.swift
//  MarvelsTests
//
//  Created by Karambalkar, Vikas - Ext on 04/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import XCTest
@testable import Marvels

class CharacterListModuleTest: XCTestCase {

    var sut: CharacterListPresenter!
    
    //MARK:  XCTestCase lifecycle
    override func setUp() {
        super.setUp()
        sut = CharacterListPresenter()
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    //MARK:  Test cases
    
    func testCharacterDataModel() {
        if let path = Bundle.main.path(forResource: "characterData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                if let character = try? decoder.decode(CharactersData.self, from: data) {
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
        sut.serviceCall(limit: 20, offset: 0) { (characterData, error) in
            XCTAssertNotNil(characterData)
        }
    }
}
