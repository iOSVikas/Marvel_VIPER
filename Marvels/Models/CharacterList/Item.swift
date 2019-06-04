//
//  Item.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation

class Item: Codable {
    var resourceURI: String?
    var name: String?
    
    private enum CodingKeys: String, CodingKey {
        case resourceURI = "resourceURI"
        case name = "name"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(resourceURI, forKey: .resourceURI)
        try container.encode(name, forKey: .name)
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.resourceURI = try container.decode(String.self, forKey: .resourceURI)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
