//
//  MarvelDemo
//
//  Created by Bhaswar Mukherjee on 15/03/22.
//

import UIKit
import Kingfisher

class CharacterDetailInfoCVCell: UICollectionViewCell {
    @IBOutlet weak private var characterDetailImagview: UIImageView!

    @IBOutlet weak private var comicNameLabel: UILabel!
    
    private var thumbnailModel = ComicDetailsModel()
    private var comicDetailsModel = ComicDetailsViewModel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configuration(comicsItems: ComicsItems){
    comicNameLabel.text = comicsItems.name
    debugPrint("name here: \(comicsItems.name)")
    let strID = comicsItems.resourceURI.components(separatedBy: "/").last
    
    characterDetailImagview.image = UIImage(systemName: "person.circle.fill")
        
        getAllComicDetails(strid: strID ?? "")
        

  }
    
    private func getAllComicDetails(strid: String){
        
        comicDetailsModel.getAllComicDetails(strid: strid) { ComicsDetailDict in
            self.thumbnailModel = ComicsDetailDict

            DispatchQueue.main.async { [self] in
                debugPrint("comic details dict BM: \(ComicsDetailDict)")
                let thumbnailstr = "\(ComicsDetailDict.thumbnail["path"] ?? "").jpg"

                let url = URL(string: thumbnailstr)
                self.characterDetailImagview.kf.setImage(with: url, placeholder: UIImage(systemName: "person.circle.fill"))
                self.characterDetailImagview.clipsToBounds = true
        }
      }
    }
  }
