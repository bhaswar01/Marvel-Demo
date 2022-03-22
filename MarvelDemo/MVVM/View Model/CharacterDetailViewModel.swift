//
//  CharacterDetailViewModel.swift
//  MarvelDemo
//
//  Created by Bhaswar Mukherjee on 15/03/22.
//

import Foundation
import UIKit

class CharacterDetailViewModel{
    
    func getAllComics(CharacterDetailID: Int, handler: @escaping ([ComicsItems]) -> ()){
        
        APIHelper.shared.getAllComics (characterDetailID: CharacterDetailID) { result in
                                         
           switch result{
        case .success(let comicsArray):
            handler(comicsArray)
        case .failure(let error):
            print(error)
               let dialogMessage = UIAlertController(title: "Alert", message: String(describing: error), preferredStyle: .alert)
                
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    debugPrint("Ok button tapped")
                 })
                dialogMessage.addAction(ok)
              
               self.getTopViewController()?.navigationController?.present(dialogMessage, animated: true, completion: nil)
          }
        }
    }
    
    func getTopViewController() -> UIViewController?{
        return UIViewController.topMostViewController()
    }
}
