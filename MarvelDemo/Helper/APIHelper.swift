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
    let privatekey = "06e000383f726e986a642bd655f63e78ac8baa91"
    let publickkey = "eeb875e9ef1a0a3690dc722942a57052"
    
    let baseURL = "https://gateway.marvel.com/v1/public/characters"
    let baseURLComics = "https://gateway.marvel.com/v1/public/comics"


    typealias Handler = (Result <[CharacterModel], Error>) -> ()
    
    typealias HandlerComics = (Result <[ComicsItems], Error>) -> ()

    func getAllCharacters(offset: Int , limit: Int , handler: @escaping Handler) {
        

        let ts = String(Date().timeIntervalSince1970)
        let hashStr = "\(ts)\(privatekey)\(publickkey)"
        let hash = hashStr.md5
        
        
        guard let url = URL(string: "\(baseURL)?ts=\(ts)&apikey=\(publickkey)&hash=\(hash)&offset=\(offset)&limit=\(limit)") else{
            return
        }
        debugPrint("URL FIRED: \(limit) and \(offset)")
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            
            do {
                let CharacterListDict = try JSONDecoder().decode(CharacterListModel.self, from: data)
                debugPrint(CharacterListDict)
                self.countofdata = (CharacterListDict.data).total
                handler(.success((CharacterListDict.data).results))
                
            } catch  {
                debugPrint(error)
                handler(.failure(error))
            }
        }.resume()
    }
    
    
    func getAllComics(characterDetailID: Int ,handler: @escaping HandlerComics) {
        
        let ts = String(Date().timeIntervalSince1970)
        let hashStr = "\(ts)\(privatekey)\(publickkey)"
        let hash = hashStr.md5
        
        
        guard let url = URL(string: "\(baseURL)/\(characterDetailID)?ts=\(ts)&apikey=\(publickkey)&hash=\(hash)") else{
            return
        }
        debugPrint("URL FIRED: \(baseURL)/\(characterDetailID)?ts=\(ts)&apikey=\(publickkey)&hash=\(hash)")

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else
            {
                return
            }
            
            do {
                let ComicsListDict = try JSONDecoder().decode(CharacterListDetailsModel.self, from: data)
                debugPrint(ComicsListDict)
                handler(.success((((ComicsListDict.data).results).first?.comics.comicsItems)!))
                
            } catch  {
//                debugPrint("error is: \(error)")
                handler(.failure(error))
            }
        }.resume()
    }
    
    
    typealias HandlerComicDetails = (Result <ComicDetailsModel, Error>) -> ()

    func getAllComicDetails(strid: String , handler: @escaping HandlerComicDetails) {

        let ts = String(Date().timeIntervalSince1970)
        let hashStr = "\(ts)\(privatekey)\(publickkey)"
        let hash = hashStr.md5
        
        debugPrint("comic image api \(baseURLComics)/\(strid)?ts=\(ts)&apikey=\(publickkey)&hash=\(hash)")
            
        guard let url = URL(string: "\(baseURLComics)/\(strid)?ts=\(ts)&apikey=\(publickkey)&hash=\(hash)") else{
            debugPrint("errorrrr")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                debugPrint("errorrrr \(String(describing: error))")
                return}
            
            do {
                let comicDetailsDict = try JSONDecoder().decode(ComicMainModel.self, from: data)
                debugPrint("comicdetaildict: \(comicDetailsDict)")
//                debugPrint("success returns: \((((comicDetailsDict.data).results)))")
                handler(.success((((comicDetailsDict.data).results.first!))))
                
            } catch  {
                debugPrint(error)
                handler(.failure(error))
            }
        }.resume()
    }
}
