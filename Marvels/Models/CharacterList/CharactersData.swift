//
//  CharactersData.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation

class CharactersData: Codable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var characters: [Character]?
    
    private enum CodingKeys: String, CodingKey {
        
        case offset = "offset"
        case limit = "limit"
        case total = "total"
        case count = "count"
        case characters = "results"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(offset, forKey: .offset)
        try container.encode(limit, forKey: .limit)
        try container.encode(total, forKey: .total)
        try container.encode(count, forKey: .count)
        try container.encode(characters, forKey: .characters)
    }
    
    public required init(from decoder: Decoder) throws {
        
        // Top level container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.offset = try container.decode(Int.self, forKey: .offset)
        self.limit = try container.decode(Int.self, forKey: .limit)
        self.total = try container.decode(Int.self, forKey: .total)
        self.count = try container.decode(Int.self, forKey: .count)
        self.characters = try container.decode([Character].self, forKey: .characters)

    }
}
