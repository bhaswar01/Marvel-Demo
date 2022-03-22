//
//  CharacterDetailViewController.swift
//  MarvelDemo
//
//  Created by Bhaswar Mukherjee on 15/03/22.
//

import UIKit
import Kingfisher

class CharacterDetailViewController: UIViewController {

    var characterDetailID : Int = 0
    private var characterDetailViewModel = CharacterDetailViewModel()
    private var comicDetailsModel = ComicDetailsViewModel()
    private var ComicsArray = [ComicsItems]()
    var thumbnail =  [String:String]()
    private var thumbnailModel = ComicDetailsModel()
    var name : String = ""
    var descriptionStr: String? = ""
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var descLabel: UILabel!
    @IBOutlet weak private var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        debugPrint("id in details: \(characterDetailID)")
        configuration()
    }
}

extension CharacterDetailViewController{
    
    static func shareInstace() -> CharacterDetailViewController?{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "CharacterDetailViewController") as? CharacterDetailViewController
    }
    
       private func configuration(){
            
            nameLabel.text = name
            nameLabel.textAlignment = .center
            if descriptionStr != nil
            {
              descLabel.text? = descriptionStr ?? ""
            }
            else
            {
                descLabel.isHidden = true
            }
            
            let thumbnailstr = "\(thumbnail["path"] ?? "").jpg"
            
            let url = URL(string: thumbnailstr)
            imageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person.circle.fill"))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            getAllComics(characterDetailID: characterDetailID)
            
        }
        
       private func getAllComics(characterDetailID: Int){
            characterDetailViewModel.getAllComics(CharacterDetailID: characterDetailID) { ComicsArray in
                
                self.ComicsArray.append(contentsOf: ComicsArray)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    debugPrint("comics array:\(ComicsArray)")
                }
            }
        }
        
}

extension CharacterDetailViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        debugPrint("comics count: \(ComicsArray.count)")
        return ComicsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterDetailInfoCVCell", for: indexPath) as? CharacterDetailInfoCVCell else { return UICollectionViewCell() }

        let comic = self.ComicsArray[indexPath.row]

        cell.configuration(comicsItems: comic)
        return cell
    }
    
 
}

extension CharacterDetailViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2.5 - 5, height: (collectionView.frame.size.height) - 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5//height
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5//width
    }
}


//6. By defaults property functions will be private then access will be levered up as per requirements

