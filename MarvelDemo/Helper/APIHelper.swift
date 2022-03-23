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
    
    typealias HandlerComics = (Result <[ComicsItems], Error>) -> ()

    func getAllCharacters(offset: Int , limit: Int , handler: @escaping Handler) {

        let ts = String(Date().timeIntervalSince1970)
        let hashStr = "\(ts)\(Constants.privatekey)\(Constants.publickkey)"
        let hash = hashStr.md5
        
        guard let url = URL(string: "\(Constants.baseURL)?ts=\(ts)&apikey=\(Constants.publickkey)&hash=\(hash)&offset=\(offset)&limit=\(limit)") else{
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
        let hashStr = "\(ts)\(Constants.privatekey)\(Constants.publickkey)"
        let hash = hashStr.md5
        
        
        guard let url = URL(string: "\(Constants.baseURL)/\(characterDetailID)?ts=\(ts)&apikey=\(Constants.publickkey)&hash=\(hash)") else{
            return
        }
        debugPrint("URL FIRED: \(Constants.baseURL)/\(characterDetailID)?ts=\(ts)&apikey=\(Constants.publickkey)&hash=\(hash)")

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
        let hashStr = "\(ts)\(Constants.privatekey)\(Constants.publickkey)"
        let hash = hashStr.md5
        
        debugPrint("comic image api \(Constants.baseURLComics)/\(strid)?ts=\(ts)&apikey=\(Constants.publickkey)&hash=\(hash)")
            
        guard let url = URL(string: "\(Constants.baseURLComics)/\(strid)?ts=\(ts)&apikey=\(Constants.publickkey)&hash=\(hash)") else{
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
