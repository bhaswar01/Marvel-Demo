//
//  CharacterListModel.swift
//  MarvelDemo
//
//  Created by Bhaswar Mukherjee on 12/03/22.
//

import Foundation

struct CharacterListModel: Codable{
    var data: OverallListModelResult
}

struct OverallListModelResult: Codable{
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [CharacterModel]
}

struct CharacterModel: Codable{
    var id: Double
    var name: String
    var description: String
    var thumbnail = [String:String]()
}

struct ThumbnailModel: Codable{
    var path: String
    var extensionname: String
    
    private enum CodingKeys: String, CodingKey{
        case path
        case extensionname = "extension"
    }
}
