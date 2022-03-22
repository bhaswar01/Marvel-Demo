//
//  CharacterListViewModel.swift
//  MarvelDemo
//
//  Created by Bhaswar Mukherjee on 12/03/22.
//

import Foundation
import UIKit

class CharacterListViewModel{
    
    func getAllCharacters(offset: Int , limit: Int, handler: @escaping ([CharacterModel]) -> ()){
        
        APIHelper.shared.getAllCharacters (offset: offset , limit: limit) { [self] result in
                                         
           switch result{
        case .success(let CharacterListArray):
            handler(CharacterListArray)
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
