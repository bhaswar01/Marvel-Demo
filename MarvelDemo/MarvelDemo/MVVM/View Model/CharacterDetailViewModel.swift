//
//  CharacterDetailViewModel.swift
//  MarvelDemo
//
//  Created by Bhaswar Mukherjee on 15/03/22.
//

import Foundation

class CharacterDetailViewModel{
    
    func getAllComics(CharacterDetailID: Int, handler: @escaping ([ComicsItems]) -> ()){
        
        APIHelper.shared.getAllComics (characterDetailID: CharacterDetailID) { result in
                                         
           switch result{
        case .success(let comicsArray):
            handler(comicsArray)
        case .failure(let error):
            print(error)
            
          }
        }
    }
}
