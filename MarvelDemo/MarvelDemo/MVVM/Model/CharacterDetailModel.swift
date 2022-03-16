//
//  CharacterDetailModel.swift
//  MarvelDemo
//
//  Created by Bhaswar Mukherjee on 15/03/22.
//

import Foundation

struct CharacterListDetailsModel: Codable{
    var data: OverallListDetailModelResult
//    private enum CodingKeys: String, CodingKey{
//        case data = "data"
//    }
}

struct OverallListDetailModelResult: Codable{
    
    var results: [ResultsCharacterDetailsModel]
}

struct ResultsCharacterDetailsModel: Codable{
    var idvalue: Double
    var name: String
    var comics: ComicsModel
    var description: String
    
    private enum CodingKeys: String, CodingKey{
        case name, comics, description
        case idvalue = "id"
    }
}

struct ComicsModel: Codable{
    var available: Int
    var comicsItems: [ComicsItems]

    private enum CodingKeys: String, CodingKey{
        case available
        case comicsItems = "items"
    }
}

struct ComicsItems: Codable{
    var resourceURI: String
    var name: String
}

