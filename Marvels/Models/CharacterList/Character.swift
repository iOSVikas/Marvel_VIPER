//
//  Character.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//


import Foundation

class Character: Codable {
    var characterId: Int?
    var name: String?
    var description: String?
    var thumbnail: Thumbnail?
    var comics: Resource?
    var series: Resource?
    var stories: Resource?
    var events: Resource?
    
    
    private enum CodingKeys: String, CodingKey {
        
        case characterId = "id"
        case name = "name"
        case description = "description"
        case thumbnail = "thumbnail"
        case comics = "comics"
        case series = "series"
        case stories = "stories"
        case events = "events"

    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(characterId, forKey: .characterId)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(thumbnail, forKey: .thumbnail)
        try container.encode(comics, forKey: .comics)
        try container.encode(series, forKey: .series)
        try container.encode(stories, forKey: .stories)
        try container.encode(events, forKey: .events)

    }
    
    public required init(from decoder: Decoder) throws {
        
        // Top level container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.characterId = try container.decode(Int.self, forKey: .characterId)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)
        self.comics = try container.decode(Resource.self, forKey: .comics)
        self.series = try container.decode(Resource.self, forKey: .series)
        self.stories = try container.decode(Resource.self, forKey: .stories)
        self.events = try container.decode(Resource.self, forKey: .events)
        
    }
    
    
    func imageUrl()-> String? {
        if let path = thumbnail?.path, let ext = thumbnail?.type {
            return "\(path).\(ext)"
        }
        return nil
    }
}
