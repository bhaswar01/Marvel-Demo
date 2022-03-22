//
//  ComicDetailsViewModel.swift
//  MarvelDemo
//
//  Created by Bhaswar Mukherjee on 17/03/22.
//

import Foundation
import UIKit

class ComicDetailsViewModel{
    
    func getAllComicDetails(strid: String, handler: @escaping (ComicDetailsModel) -> ()){
        
        APIHelper.shared.getAllComicDetails(strid: strid) { result in
           switch result{
        case .success(let comicsImgDict):
            handler(comicsImgDict)
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
