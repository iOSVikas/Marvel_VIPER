//
//  Thumbnail.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation

class Thumbnail: Codable {
    var path: String?
    var type: String?
    
    private enum CodingKeys: String, CodingKey {
        case path = "path"
        case type = "extension"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(path, forKey: .path)
        try container.encode(type, forKey: .type)
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decode(String.self, forKey: .path)
        self.type = try container.decode(String.self, forKey: .type)
    }
}
