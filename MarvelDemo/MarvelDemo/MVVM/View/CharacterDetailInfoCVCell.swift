//
//  MarvelDemo
//
//  Created by Bhaswar Mukherjee on 15/03/22.
//

import UIKit

class CharacterDetailInfoCVCell: UICollectionViewCell {
    @IBOutlet weak var characterDetailImagview: UIImageView!

    @IBOutlet weak var comicNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
func configuration(comicsItems: ComicsItems){
    comicNameLabel.text = comicsItems.name
    print("name here: \(comicsItems.name)")
    characterDetailImagview.image = UIImage(systemName: "person.circle.fill")
    
  }
    
    
}
