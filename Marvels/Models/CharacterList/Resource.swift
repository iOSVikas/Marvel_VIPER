//
//  Resource.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation

class Resource: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [Item]?
    
    private enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"

    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(available, forKey: .available)
        try container.encode(collectionURI, forKey: .collectionURI)
        try container.encode(items, forKey: .items)

    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.available = try container.decode(Int.self, forKey: .available)
        self.collectionURI = try container.decode(String.self, forKey: .collectionURI)
        self.items = try container.decode([Item].self, forKey: .items)
    }
}

