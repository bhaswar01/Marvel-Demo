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
    var characterDetailViewModel = CharacterDetailViewModel()
    var ComicsArray = [ComicsItems]()
    var thumbnail =  [String:String]()
    var name : String = ""
    var descriptionStr: String? = ""
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("id in details: \(characterDetailID)")
        // Do any additional setup after loading the view.
        configuration()
    }
}

extension CharacterDetailViewController{
    
    static func shareInstace() -> CharacterDetailViewController?{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "CharacterDetailViewController") as? CharacterDetailViewController
    }
    
        func configuration(){
            
//            collectionView.register(UINib(nibName: "CharacterDetailInfoCVCell", bundle: nil), forCellWithReuseIdentifier: "CharacterDetailInfoCVCell")
            
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

//            tableView.dataSource = self
//            tableView.register(UINib(nibName: "CharacterListCell", bundle: nil), forCellReuseIdentifier: "CharacterListCell")
            getAllComics(characterDetailID: characterDetailID)
            
        }
        
        func getAllComics(characterDetailID: Int){
            characterDetailViewModel.getAllComics(CharacterDetailID: characterDetailID) { ComicsArray in
                
                self.ComicsArray.append(contentsOf: ComicsArray)
                
                DispatchQueue.main.async {
//                    self.tableView.reloadData()
                    self.collectionView.reloadData()
                    print("comics array:\(ComicsArray)")
                }
            }
        }
        
}

extension CharacterDetailViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("comics count: \(ComicsArray.count)")
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
