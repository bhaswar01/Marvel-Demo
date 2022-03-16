//
//  CharacterListViewModel.swift
//  MarvelDemo
//
//  Created by Bhaswar Mukherjee on 12/03/22.
//

import Foundation

class CharacterListViewModel{
    
    func getAllCharacters(offset: Int , limit: Int, handler: @escaping ([CharacterModel]) -> ()){
        
        APIHelper.shared.getAllCharacters (offset: offset , limit: limit) { result in
                                         
           switch result{
        case .success(let CharacterListArray):
            handler(CharacterListArray)
        case .failure(let error):
            print(error)
            
          }
        }
    }
}
