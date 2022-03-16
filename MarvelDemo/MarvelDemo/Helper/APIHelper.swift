//
//  APIHelper.swift
//  MarvelDemo
//
//  Created by Bhaswar Mukherjee on 12/03/22.
//

import Foundation
import UIKit

class APIHelper {
    
    static let shared = APIHelper()
    var countofdata : Int = 0

    typealias Handler = (Result <[CharacterModel], Error>) -> ()
    let baseURL = "https://gateway.marvel.com/v1/public/characters"
    
    typealias HandlerComics = (Result <[ComicsItems], Error>) -> ()

    func getAllCharacters(offset: Int , limit: Int , handler: @escaping Handler) {
        
        let privatekey = "06e000383f726e986a642bd655f63e78ac8baa91"
        let publickkey = "eeb875e9ef1a0a3690dc722942a57052"
        let ts = String(Date().timeIntervalSince1970)
        let hashStr = "\(ts)\(privatekey)\(publickkey)"
        let hash = hashStr.md5
        
        
        guard let url = URL(string: "\(baseURL)?ts=\(ts)&apikey=\(publickkey)&hash=\(hash)&offset=\(offset)&limit=\(limit)") else{
            return
        }
        print("URL FIRED: \(limit) and \(offset)")
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            
            do {
                let CharacterListDict = try JSONDecoder().decode(CharacterListModel.self, from: data)
                print(CharacterListDict)
                self.countofdata = (CharacterListDict.data).total
                handler(.success((CharacterListDict.data).results))
                
            } catch  {
                print(error)
                handler(.failure(error))
            }
        }.resume()
    }
    
    
    func getAllComics(characterDetailID: Int ,handler: @escaping HandlerComics) {
        
        let privatekey = "06e000383f726e986a642bd655f63e78ac8baa91"
        let publickkey = "eeb875e9ef1a0a3690dc722942a57052"
        let ts = String(Date().timeIntervalSince1970)
        let hashStr = "\(ts)\(privatekey)\(publickkey)"
        let hash = hashStr.md5
        
        
        guard let url = URL(string: "\(baseURL)/\(characterDetailID)?ts=\(ts)&apikey=\(publickkey)&hash=\(hash)") else{
            return
        }
        print("URL FIRED: \(baseURL)/\(characterDetailID)?ts=\(ts)&apikey=\(publickkey)&hash=\(hash)")

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else
            {
                return
            }
            
            do {
                let ComicsListDict = try JSONDecoder().decode(CharacterListDetailsModel.self, from: data)
                print(ComicsListDict)
                handler(.success((((ComicsListDict.data).results).first?.comics.comicsItems)!))
                
            } catch  {
                print("error is: \(error)")
                handler(.failure(error))
            }
        }.resume()
    }
}
