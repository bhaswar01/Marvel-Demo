//
//  ComicDetailsModel.swift
//  MarvelDemo
//
//  Created by Bhaswar Mukherjee on 17/03/22.
//

import Foundation

struct ComicMainModel: Codable{
    var data: OverallComicDetailsModelResult
}

struct OverallComicDetailsModelResult: Codable{
    
    var results: [ComicDetailsModel]
}

struct ComicDetailsModel: Codable{
    
    var thumbnail = [String:String]()
}

